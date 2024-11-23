import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:im_okay/Models/alert_area.dart';
import 'package:im_okay/Services/API%20Services/polygons.dart' as data;
import 'package:geolocator/geolocator.dart';
import 'package:point_in_polygon/point_in_polygon.dart';

List<AlertArea> polygons = data.polygons;
AlertArea activeAlertArea = AlertArea.none();

initStream() {
  getAlertAreaStream().listen((event) {
    activeAlertArea = event;
  });
}

StreamController<AlertArea>? _alertAreaStreamController;

StreamController<AlertArea> get alertAreaStreamController {
  if (_alertAreaStreamController == null) {
    _alertAreaStreamController = StreamController<AlertArea>();
    _alertAreaStreamController?.addStream(getAlertAreaStream());
  }

  return _alertAreaStreamController!;
}

Stream<AlertArea> getAlertAreaStream() async* {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return;
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return;
  }

  LocationSettings settings = LocationSettings(accuracy: LocationAccuracy.best);
  Stream<Position> positionStream = Geolocator.getPositionStream(locationSettings: settings);
  final transformer =
      StreamTransformer<Position, AlertArea>.fromHandlers(handleData: (data, sink) async {
    if (_locationInPolygon(data, activeAlertArea.coordinates)) {
      return;
    }

    AlertArea newArea = await _getUserAlertZone();
    sink.add(newArea);
  });

  yield* positionStream.transform(transformer).asBroadcastStream(
      onCancel: (subscription) => subscription.pause(),
      onListen: (subscription) => subscription.resume);
}

Future<AlertArea> _getUserAlertZone() async {
  Position position = await Geolocator.getCurrentPosition();
  List<AlertArea> closestAreas = getClosestAlertAreas(position);
  for (AlertArea area in closestAreas) {
    if (_locationInPolygon(position, area.coordinates)) {
      return area;
    }
  }

  return AlertArea.none();
}

bool _locationInPolygon(Position position, List<List<num>> polygon) {
  if (polygon.isEmpty) {
    return false;
  }
  return Poly.isPointInPolygon(Point(x: position.latitude, y: position.longitude),
      polygon.map((point) => Point(x: point[0].toDouble(), y: point[1].toDouble())).toList());
}

List<AlertArea> getClosestAlertAreas(Position userPosition) {
  List<AlertArea> areas = [polygons[0]];
  List<double> distances = [
    calcPointDistance(userPosition, Point(x: areas[0].lat.toDouble(), y: areas[0].lng.toDouble()))
  ];

  int maxSize = 5;
  for (AlertArea area in polygons) {
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

double calcPointDistance(Position userPosition, Point areaCenter) {
  return sqrt(
      pow(userPosition.latitude - areaCenter.x, 2) + pow(userPosition.longitude - areaCenter.y, 2));
}

class LocationProvider with ChangeNotifier {
  AlertArea get alertArea => activeAlertArea;
  LocationProvider() {
    getAlertAreaStream().listen((event) {
      debugPrint("changing location to ${event.name}");
      activeAlertArea = event;
      notifyListeners();
    });
  }
}
