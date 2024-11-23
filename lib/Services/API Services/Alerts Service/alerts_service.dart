import 'package:im_okay/Enums/endpoint_enums.dart';
import 'package:im_okay/Models/alert.dart';
import 'package:im_okay/Utils/http_utils.dart';

class AlertsService {
  static reportActiveAlert(Alert alert) async {
    String endpoint = AlertsController.reportActiveAlert.endpoint;
    var body = {'timestamp': alert.timestamp};
    // debugPrint(
    // "is alert local? ${alert.alertArea == activeAlertArea.name}: incoming area: ${alert.alertArea}, local: ${activeAlertArea.name}");
    String response = await HttpUtils.post(endpoint: endpoint, body: body);
  }
}
