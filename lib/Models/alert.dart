class Alert {
  String alertArea = '';
  String id = '';
  int timestamp = 0;
  int type = -1;

  Alert.fromJson(Map<String, dynamic> json)
      : alertArea = json['alertArea'],
        id = json['id'],
        timestamp = int.parse(json['timestamp']),
        type = int.parse(json['type']);
}
