import 'dart:async';
import 'dart:math';
import 'package:im_okay/Models/alert_area.dart';
import 'package:im_okay/Services/ApiServices/polygons.dart' as data;
import 'package:geolocator/geolocator.dart';
import 'package:im_okay/Services/LocationService/i_location_service.dart';
import 'package:point_in_polygon/point_in_polygon.dart';

class LocationService implements ILocationService {
  List<AlertArea> polygons = data.polygons;

  @override
  Future<AlertArea> getUserAlertZone() async {
    await checkOrRequestLocationPermission();
    Position position = await Geolocator.getCurrentPosition();
    List<AlertArea> closestAreas = _getClosestAlertAreas(position);
    for (AlertArea area in closestAreas) {
      if (_locationInPolygon(position, area.coordinates)) {
        return area;
      }
    }

    return AlertArea.none();
  }

  @override
  Future<bool> checkOrRequestLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  bool _locationInPolygon(Position position, List<List<num>> polygon) {
    if (polygon.isEmpty) {
      return false;
    }
    return Poly.isPointInPolygon(Point(x: position.latitude, y: position.longitude),
        polygon.map((point) => Point(x: point[0].toDouble(), y: point[1].toDouble())).toList());
  }

  List<AlertArea> _getClosestAlertAreas(Position userPosition) {
    List<AlertArea> areas = [polygons[0]];
    List<double> distances = [
      _calcPointDistance(
          userPosition, Point(x: areas[0].lat.toDouble(), y: areas[0].lng.toDouble()))
    ];

    int maxSize = 5;
    for (AlertArea area in polygons) {
      double currentDistance =
          _calcPointDistance(userPosition, Point(x: area.lat.toDouble(), y: area.lng.toDouble()));

      for (int i = 0; i < areas.length; i++) {
        if (currentDistance <= distances[i]) {
          areas.insert(i, area);
          distances.insert(i, currentDistance);
          if (areas.length > maxSize) {
            areas.removeLast();
            distances.removeLast();
          }

          break;
        }
      }
    }

    return areas;
  }

  double _calcPointDistance(Position userPosition, Point areaCenter) {
    return sqrt(pow(userPosition.latitude - areaCenter.x, 2) +
        pow(userPosition.longitude - areaCenter.y, 2));
  }
}
