import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:im_okay/Models/alert.dart';
import 'package:im_okay/Services/API%20Services/Alerts%20Service/alerts_service.dart';
import 'package:im_okay/Services/API%20Services/CacheService/Abstract/cache_service.dart';
import 'package:im_okay/Services/API%20Services/CacheService/Concrete/local_cache_service.dart';
import 'package:im_okay/Services/Logger/logger.dart';
import 'package:im_okay/Services/Notification%20Services/in_app_message_service.dart';
import 'package:im_okay/Services/location_service.dart' as location_service;
import 'package:im_okay/Services/location_service.dart';
import 'package:im_okay/Services/router_service.dart';
import 'package:im_okay/firebase_options.dart';
import 'package:localstorage/localstorage.dart';

CacheService cacheService = LocalCacheService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  FirebaseMessaging.instance.requestPermission();
  await Geolocator.requestPermission();

  await initLocalStorage();
  await FirebaseMessaging.instance.setAutoInitEnabled(true);

  if (!kReleaseMode) {
    try {
      debugPrint("Launching authentication emulator");
      await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    } catch (e) {
      debugPrint("Theres an error!");
    }
  }

  //initialize location stream.
  location_service.initStream();
  location_service.getAlertAreaStream().listen(
    (event) async {
      debugPrint("unsubscribing from ${previousAlertArea.id}, subscribing to ${event.id}");
      await FirebaseMessaging.instance.unsubscribeFromTopic(previousAlertArea.id);
      await FirebaseMessaging.instance.subscribeToTopic(event.id);
    },
  );
  // await FirebaseMessaging.instance.subscribeToTopic("users");
  FirebaseMessaging.onBackgroundMessage(notifyUserIsInAlertZoneBackground);

  FirebaseMessaging.onMessage.listen(
    (event) async {
      notifyUserIsInAlertZoneForeground(event);
    },
  );

  FirebaseAuth.instance.idTokenChanges().listen(
    (user) async {
      Logger.log('token refresh event');
      if (user == null) {
        Logger.log('no user');
        return;
      }

      String? token = await user.getIdToken();
      if (token == null) {
        return;
      }

      cacheService.setAuthToken(token);
      Logger.log('cached token');
    },
  );

  runApp(MaterialApp.router(
    debugShowCheckedModeBanner: false,
    locale: const Locale('he', 'IL'),
    supportedLocales: const [Locale('he', 'IL')],
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    routerConfig: globalRouter,
  ));
}

@pragma('vm:entry-point')
Future<void> notifyUserIsInAlertZoneBackground(RemoteMessage event) async {
  if (event == null) {
    return;
  }
  Logger.log('intercepting in background');
  Alert alert = Alert.fromJson(event.data);
  await AlertsService.reportActiveAlert(alert);
  Logger.log("done!!");
}

Future<void> notifyUserIsInAlertZoneForeground(RemoteMessage event) async {
  Logger.log('intercepting in foreground');

  if (event == null) {
    return;
  }

  InAppMessageService.showToast(message: "אזעקה באיזורך!");
  Alert alert = Alert.fromJson(event.data);
  await AlertsService.reportActiveAlert(alert);
  Logger.log("done!!");
}
