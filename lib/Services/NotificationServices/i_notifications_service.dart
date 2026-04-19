abstract class INotificationsService {
  void showToast({required String message});

  Future<String> getFcmToken();

  Future<void> triggerLocalNotification({required String title, String? body});

  Future<void> triggerFriendRequestNotification();
}
