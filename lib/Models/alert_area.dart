// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class AlertArea {
  String id = "";
  String name = "";
  String name_en = "";
  String zone = "";
  String zone_en = "";
  int countdown = 0;
  num lat = 0;
  num lng = 0;

  List<List<num>> coordinates = [];

  AlertArea.none() {
    id = "NONE";
    name = "NONE";
  }

  AlertArea(
      {required this.id,
      required this.name,
      required this.name_en,
      required this.zone,
      required this.zone_en,
      required this.countdown,
      required this.lat,
      required this.lng,
      required this.coordinates});

  AlertArea.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    name_en = map['name_en'];
    zone = map['zone'];
    zone_en = map['zone_en'];
    countdown = int.parse(map['countdown']);
    lat = num.parse(map['lat']);
    lng = num.parse(map['lng']);
    coordinates = List<List<num>>.from(map['coordinates']);
  }

  static List<AlertArea> parseList(String json) {
    List dynamicList = jsonDecode(json);
    List<AlertArea> response = dynamicList.map(parseSingle).toList();
    return response;
  }

  static AlertArea parseSingle(dynamic obj) {
    return AlertArea.fromJson(obj);
  }
}
