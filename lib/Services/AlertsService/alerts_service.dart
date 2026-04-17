import 'package:im_okay/Enums/endpoint_enums.dart';
import 'package:im_okay/Models/alert.dart';
import 'package:im_okay/Models/alert_area.dart';
import 'package:im_okay/Services/AlertsService/i_alerts_service.dart';
import 'package:im_okay/Services/LocationService/i_location_service.dart';
import 'package:im_okay/Services/service_injector.dart';
import 'package:im_okay/Utils/http_utils.dart';

class AlertsService implements IAlertsService {
  late ILocationService _locationService;

  AlertsService() {
    _locationService = serviceInjector.get<ILocationService>();
  }

  Future<bool> _checkIfAlertIsHere(Alert alert) async {
    AlertArea currentAlertZone = await _locationService.getUserAlertZone();
    return alert.id == currentAlertZone.id;
  }

  @override
  reportAlertIfNeeded(Alert alert) async {
    if (!await _checkIfAlertIsHere(alert)) {
      return;
    }

    await reportAlert(alert);
    // String response = await HttpUtils.post(endpoint: endpoint, body: body);
  }

  @override
  reportAlert(Alert alert) async {
    String endpoint = AlertsController.reportActiveAlert.endpoint;
    var body = {'timestamp': alert.timestamp};

    var response = await HttpUtils.post(endpoint: endpoint, body: body);
  }
}
