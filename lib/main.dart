import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:im_okay/Enums/notification_type_enum.dart';
import 'package:im_okay/Logger/i_logger.dart';
import 'package:im_okay/Models/alert.dart';
import 'package:im_okay/Services/AlertsService/i_alerts_service.dart';
import 'package:im_okay/Services/CacheService/Abstract/i_cache_service.dart';
import 'package:im_okay/Services/KinInteractionService/i_kin_interaction_service.dart';
import 'package:im_okay/Services/NotificationServices/i_notifications_service.dart';
import 'package:im_okay/Routers/global_router.dart';
import 'package:im_okay/Services/service_injector.dart';
import 'package:im_okay/firebase_options.dart';
import 'package:localstorage/localstorage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

late ILogger _logger;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  await FirebaseMessaging.instance.setAutoInitEnabled(true);

  String envFileName = kReleaseMode ? "prod.env" : "local.env";

  await registerServices();
  await dotenv.load(fileName: envFileName);
  ICacheService cacheService = serviceInjector.get<ICacheService>();
  cacheService.cacheDotEnvData();
  _logger = serviceInjector.get<ILogger>();

  if (!kReleaseMode) {
    try {
      _logger.log("connecting to auth emulator");
      String authEmulatorUrl = dotenv.get("authEmulatorUrl");
      int authEmulatorPort = dotenv.getInt("authEmulatorPort");
      await FirebaseAuth.instance.useAuthEmulator(authEmulatorUrl, authEmulatorPort);
      _logger.log("connected to auth emulator successfully!");
    } catch (e) {
      _logger.log("Auth emulator connection failed!");
    }
  }

  await FirebaseMessaging.instance.subscribeToTopic("users");
  FirebaseMessaging.onBackgroundMessage(notifyUserIsInAlertZoneBackground);

  FirebaseMessaging.onMessage.listen(
    (event) async {
      await notifyUserIsInAlertZoneForeground(event);
    },
  );

  FirebaseAuth.instance.authStateChanges().listen(
    (user) async {
      if (user != null) {
        var kinService = serviceInjector.get<IKinInteractionsService>();
        var cacheService = serviceInjector.get<ICacheService>();
        var contactAssociations = await kinService.getContactToAppUserAssociations();
        cacheService.cacheUsers(contactAssociations);
      }
    },
  );

  // FirebaseMessaging.

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

  NotificationTypeEnum type = NotificationTypeEnum.parse(event.data['NotificationType'].toString());
  if (type == NotificationTypeEnum.invalid) {
    return;
  }

  await registerServices();
  final logger = serviceInjector.get<ILogger>();
  logger.log('intercepted notification of type $type');

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final notificationsService = serviceInjector.get<INotificationsService>();

  switch (type) {
    case NotificationTypeEnum.activeAlert:
      {
        final alertsService = serviceInjector.get<IAlertsService>();
        logger.log('parsing alert zone');
        Alert alert = Alert.fromJson(event.data);
        logger.log('alert zone is ${alert.alertArea}');
        bool isAlertHere = await alertsService.isAlertHere(alert);
        if (!isAlertHere) {
          return;
        }

        await alertsService.reportAlert(alert);
        await notificationsService.triggerActiveAlertNotification();
        break;
      }

    case NotificationTypeEnum.friendRequest:
      {
        await notificationsService.triggerFriendRequestNotification();
        break;
      }

    default:
      {
        return;
      }
  }

  // await notificationsService.sendLocalNotification(
  //     event.notification!.title!, event.notification!.body!);
}

Future<void> notifyUserIsInAlertZoneForeground(RemoteMessage event) async {
  _logger.log('intercepting in foreground');

  if (event == null) {
    return;
  }

  final alertsService = serviceInjector.get<IAlertsService>();
  final notificationsService = serviceInjector.get<INotificationsService>();

  notificationsService.showToast(message: event.notification?.body ?? "No notification");
  // Alert alert = Alert.fromJson(event.data);
  // await alertsService.reportAlertIfNeeded(alert);
  _logger.log("done!!");
}
