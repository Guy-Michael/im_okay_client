import 'package:im_okay/Models/alert.dart';

abstract class IAlertsService {
  Future<bool> isAlertHere(Alert alert);

  reportAlert(Alert alert);
}
