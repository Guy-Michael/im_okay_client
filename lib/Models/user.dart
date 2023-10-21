import 'dart:convert';

class User {
  final String username;
  final String nameHeb;
  final String location;
  final int lastSeen;
  final String gender;

  const User(
      {this.username = '',
      this.nameHeb = '',
      this.location = '',
      this.lastSeen = 0,
      this.gender = ''});

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
    return json.containsKey(key) && json[key] != null ? json[key] : '';
  }

  static String generateAccessToken(String username, String password) {
    String accessToken = base64.encode(utf8.encode("$username:$password"));
    return accessToken;
  }
}
