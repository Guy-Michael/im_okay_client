class Alert {
  String alertArea = '';
  int timestamp = 0;
  int type = -1;

  Alert.fromJson(Map<String, dynamic> json)
      : alertArea = json['alertArea'],
        timestamp = int.parse(json['timestamp']),
        type = int.parse(json['type']);
}
