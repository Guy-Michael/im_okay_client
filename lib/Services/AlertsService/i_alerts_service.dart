import 'package:im_okay/Models/alert.dart';

abstract class IAlertsService {
  reportAlertIfNeeded(Alert alert);

  reportAlert(Alert alert);
}
