import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:im_okay/Services/NotificationServices/i_notifications_service.dart';

class NotificationsService implements INotificationsService {
  @override
  void showToast({required String message}) {
    Fluttertoast.showToast(msg: message);
  }

  @override
  Future<bool> requestNotificationsPermissions() async {
    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      sound: true,
    );

    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }
}
