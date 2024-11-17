import 'dart:math';

import 'package:im_okay/Models/alert_area.dart';
import 'package:im_okay/Services/API%20Services/polygons.dart' as data;

import 'package:geolocator/geolocator.dart';
import 'package:im_okay/Utils/http_utils.dart';
import 'package:point_in_polygon/point_in_polygon.dart';

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition();
}

List<AlertArea> polygons = data.polygons;

class LocationService {
  static Future<String> getUserAlertZone() async {
    Position position = await _determinePosition();
    List<AlertArea> closestAreas = getClosestAlertAreas(position);
    for (AlertArea area in closestAreas) {
      logger.i('im-okay: area ' + area.name_en);
      if (locationInPolygon(position, area.coordinates)) {
        return area.name_en;
      }
    }

    return "NO AREA";
  }

  static bool locationInPolygon(Position position, List<List<num>> polygon) {
    return Poly.isPointInPolygon(Point(x: position.latitude, y: position.longitude),
        polygon.map((point) => Point(x: point[0].toDouble(), y: point[1].toDouble())).toList());
  }

  static List<AlertArea> getClosestAlertAreas(Position userPosition) {
    List<AlertArea> areas = [polygons[0]];
    List<double> distances = [
      calcPointDistance(userPosition, Point(x: areas[0].lat.toDouble(), y: areas[0].lng.toDouble()))
    ];

    int maxSize = 10;
    for (AlertArea area in polygons) {
      // if (locationInPolygon(userPosition, area.coordinates)) {
      //   return [area];
      // }

      double currentDistance =
          calcPointDistance(userPosition, Point(x: area.lat.toDouble(), y: area.lng.toDouble()));

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

  static double calcPointDistance(Position userPosition, Point areaCenter) {
    return sqrt(pow(userPosition.latitude - areaCenter.x, 2) +
        pow(userPosition.longitude - areaCenter.y, 2));
  }
}
