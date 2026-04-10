import 'package:fluttertoast/fluttertoast.dart';
import 'package:im_okay/Services/NotificationServices/i_notifications_service.dart';
import 'package:im_okay/Services/PermissionsService/i_permissions_service.dart';
import 'package:im_okay/Services/service_injector.dart';

class NotificationsService implements INotificationsService {
  late final IPermissionsService _permissionsService;

  NotificationsService() {
    _permissionsService = serviceInjector.get<IPermissionsService>();
  }

  @override
  void showToast({required String message}) {
    Fluttertoast.showToast(msg: message);
  }
}
