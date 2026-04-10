abstract class IPermissionsService {
  Future<bool> requestContactsPermission();

  Future<bool> requestLocationPermissions();

  Future<bool> requestNotificationPermissions();
}
