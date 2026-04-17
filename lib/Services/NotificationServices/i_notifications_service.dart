abstract class INotificationsService {
  void showToast({required String message});

  Future<String> getFcmToken();

  Future<void> sendLocalNotification(String title, String body);
}
