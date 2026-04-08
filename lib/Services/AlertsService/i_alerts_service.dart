import 'package:im_okay/Models/alert.dart';

abstract class IAlertsService {
  Future<bool> checkIfAlertIsHere(Alert alert);

  reportAlertIfNeeded(Alert alert);
}
