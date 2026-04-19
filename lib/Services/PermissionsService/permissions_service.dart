import 'package:im_okay/Enums/app_permissions_enum.dart';
import 'package:im_okay/Services/PermissionsService/i_permissions_service.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsService implements IPermissionsService {
  @override
  Future<bool> requestContactsPermission() async {
    PermissionStatus contactPermissionStatus = await Permission.contacts.request();
    return contactPermissionStatus.isGranted;
  }

  @override
  Future<bool> requestLocationPermissions() async {
    PermissionStatus locationForegroundPermissions = await Permission.locationWhenInUse.request();

    if (locationForegroundPermissions.isDenied ||
        locationForegroundPermissions.isPermanentlyDenied) {
      return false;
    }

    PermissionStatus locationAlwaysPermissions = await Permission.locationAlways.request();
    return locationAlwaysPermissions.isGranted;
  }

  @override
  Future<bool> requestNotificationPermissions() async {
    PermissionStatus notificationsPermissionStatus = await Permission.notification.request();
    return notificationsPermissionStatus.isGranted;
  }

  @override
  Future<bool> checkPermission(AppPermissions permission) async {
    switch (permission) {
      case AppPermissions.contacts:
        return await Permission.contacts.isGranted;

      case AppPermissions.location:
        return await Permission.location.isGranted;

      case AppPermissions.notifications:
        return await Permission.notification.isGranted;
    }
  }
}
