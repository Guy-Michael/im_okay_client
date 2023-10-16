import 'dart:convert';

class User {
  String username;
  String nameHeb;
  String location;
  int lastSeen;
  String gender;

  User(this.username, this.nameHeb, this.location, this.lastSeen, this.gender);

  User.fromJson(Map<String, dynamic> json)
      : username = getValueOrDefault(json, 'username'),
        nameHeb = getValueOrDefault(json, 'nameHeb'),
        location = getValueOrDefault(json, 'location'),
        lastSeen = getValueOrDefault(json, 'lastSeen'),
        gender = getValueOrDefault(json, 'gender');

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'nameHeb': nameHeb,
      'location': location,
      'lastSeen': lastSeen,
      'gender': gender
    };
  }

  static dynamic getValueOrDefault(Map<String, dynamic> json, key) {
    return json.containsKey(key) ? json[key] : '';
  }

  static String generateAccessToken(String username, String password) {
    String accessToken = base64.encode(utf8.encode("$username:$password"));
    return accessToken;
  }
}
