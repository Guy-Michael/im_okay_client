import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:im_okay/Models/alert.dart';
import 'package:im_okay/Services/API%20Services/Alerts%20Service/alerts_service.dart';
import 'package:im_okay/Services/API%20Services/CacheService/Abstract/cache_service.dart';
import 'package:im_okay/Services/API%20Services/CacheService/Concrete/local_cache_service.dart';
import 'package:im_okay/Services/Logger/my_logger.dart';
import 'package:im_okay/Services/Notification%20Services/in_app_message_service.dart';
import 'package:im_okay/Services/router_service.dart';
import 'package:im_okay/firebase_options.dart';
import 'package:localstorage/localstorage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

CacheService cacheService = LocalCacheService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  FirebaseMessaging.instance.requestPermission();
  await Geolocator.requestPermission();

  await initLocalStorage();
  await FirebaseMessaging.instance.setAutoInitEnabled(true);

  String envFileName = kReleaseMode ? "prod.env" : "local.env";
  await dotenv.load(fileName: envFileName);

  if (!kReleaseMode) {
    try {
      debugPrint("Launching authentication emulator");
      String authEmulatorUrl = dotenv.get("authEmulatorUrl");
      int authEmulatorPort = dotenv.getInt("authEmulatorPort");
      await FirebaseAuth.instance.useAuthEmulator(authEmulatorUrl, authEmulatorPort);
      // await FirebaseAuth.instance.useAuthEmulator('192.168.68.105', 9099);
    } catch (e) {
      logger.log("Auth emulator connection failed!");
    }
  }

  await FirebaseMessaging.instance.subscribeToTopic("users");
  FirebaseMessaging.onBackgroundMessage(notifyUserIsInAlertZoneBackground);

  FirebaseMessaging.onMessage.listen(
    (event) async {
      await notifyUserIsInAlertZoneForeground(event);
    },
  );

  // FirebaseAuth.instance.idTokenChanges().listen(
  //   (user) async {
  //     Logger.log('token refresh event');
  //     if (user == null) {
  //       Logger.log('no user');
  //       return;
  //     }

  //     String? token = await user.getIdToken();
  //     if (token == null) {
  //       return;
  //     }

  //     Logger.log('new token: $token');
  //     cacheService.setAuthToken(token);
  //   },
  // );

  runApp(ProviderScope(
      child: MaterialApp.router(
    debugShowCheckedModeBanner: false,
    locale: const Locale('he', 'IL'),
    supportedLocales: const [Locale('he', 'IL')],
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    routerConfig: globalRouter,
  )));
}

@pragma('vm:entry-point')
Future<void> notifyUserIsInAlertZoneBackground(RemoteMessage event) async {
  if (event == null) {
    return;
  }
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  logger.log('intercepting in background');
  Alert alert = Alert.fromJson(event.data);
  await AlertsService.reportAlertIfNeeded(alert);
  logger.log("done!!");
}

Future<void> notifyUserIsInAlertZoneForeground(RemoteMessage event) async {
  logger.log('intercepting in foreground');

  if (event == null) {
    return;
  }

  InAppMessageService.showToast(message: "אזעקה באיזורך!");
  Alert alert = Alert.fromJson(event.data);
  await AlertsService.reportAlertIfNeeded(alert);
  logger.log("done!!");
}
