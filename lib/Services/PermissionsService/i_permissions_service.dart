import 'package:im_okay/Enums/app_permissions_enum.dart';

abstract class IPermissionsService {
  Future<bool> requestContactsPermission();

  Future<bool> requestLocationPermissions();

  Future<bool> requestNotificationPermissions();

  Future<bool> checkPermission(AppPermissions permission);
}
