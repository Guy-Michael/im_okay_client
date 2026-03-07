import 'package:im_okay/Enums/endpoint_enums.dart';
import 'package:im_okay/Models/alert.dart';
import 'package:im_okay/Models/alert_area.dart';
import 'package:im_okay/Utils/http_utils.dart';
import 'package:im_okay/Services/location_service.dart' as location_service;

class AlertsService {
  static Future<bool> checkIfAlertIsHere(Alert alert) async {
    AlertArea currentAlertZone = await location_service.getUserAlertZone();
    return alert.id == currentAlertZone.id;
  }

  static reportAlertIfNeeded(Alert alert) async {
    if (!await checkIfAlertIsHere(alert)) {
      return;
    }

    String endpoint = AlertsController.reportActiveAlert.endpoint;
    var body = {'timestamp': alert.timestamp};

    var response = await HttpUtils.post(endpoint: endpoint, body: body);
    // String response = await HttpUtils.post(endpoint: endpoint, body: body);
  }
}
