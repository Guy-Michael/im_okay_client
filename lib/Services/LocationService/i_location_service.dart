import 'dart:async';
import 'package:im_okay/Models/alert_area.dart';

abstract class ILocationService {
  Future<AlertArea> getUserAlertZone();

  Future<bool> checkOrRequestLocationPermission();
}
