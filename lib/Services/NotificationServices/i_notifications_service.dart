abstract class INotificationsService {
  void showToast({required String message});

  Future<bool> requestNotificationsPermissions();
}
