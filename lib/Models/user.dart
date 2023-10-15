import 'dart:convert';

class User {
  String username;
  String hebName;
  String location;
  String password;
  int lastSeen;

  User(
      this.username, this.hebName, this.location, this.password, this.lastSeen);

  User.fromJson(Map<String, dynamic> json)
      : username = getValueOrDefault(json, 'username'),
        hebName = getValueOrDefault(json, 'hebName'),
        location = getValueOrDefault(json, 'location'),
        lastSeen = getValueOrDefault(json, 'lastSeen'),
        password = '' {}

  static getValueOrDefault(Map<String, dynamic> json, key) {
    return json.containsKey(key) ? json[key] : '';
  }

  getAccessToken() {
    String accessToken = base64.encode(utf8.encode("$username:$password"));
    return accessToken;
  }

  static generateAccessToken(String username, String password) {
    String accessToken = base64.encode(utf8.encode("$username:$password"));
    return accessToken;
  }
}
