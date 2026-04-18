import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:im_okay/Services/NotificationServices/i_notifications_service.dart';
import 'package:im_okay/Services/PermissionsService/i_permissions_service.dart';
import 'package:im_okay/Services/service_injector.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsService implements INotificationsService {
  late final IPermissionsService _permissionsService;
  late final FlutterLocalNotificationsPlugin _localNotificationsPlugin;

  NotificationsService._({required FlutterLocalNotificationsPlugin notificationsPlugin}) {
    _permissionsService = serviceInjector.get<IPermissionsService>();
    _localNotificationsPlugin = notificationsPlugin;
  }

  static Future<NotificationsService> init() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    //TODO: add IOS settings

    InitializationSettings initSettings = InitializationSettings(android: androidSettings);
    FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();
    await notificationsPlugin.initialize(settings: initSettings);

    NotificationsService service = NotificationsService._(notificationsPlugin: notificationsPlugin);

    return service;
  }

  @override
  void showToast({required String message}) {
    Fluttertoast.showToast(msg: message);
  }

  @override
  Future<String> getFcmToken() async {
    String fcmToken = await FirebaseMessaging.instance.getToken() ?? '';
    return fcmToken;
  }

  @override
  Future<void> sendLocalNotification(String title, String body) async {
    await _permissionsService.requestNotificationPermissions();
    await _localNotificationsPlugin.show(
        id: 0,
        title: title,
        body: body,
        notificationDetails: NotificationDetails(
            android: AndroidNotificationDetails("report_alert_id", "report alert",
                channelDescription: "Reports and alert",
                importance: Importance.max,
                priority: Priority.high)));
  }
}
