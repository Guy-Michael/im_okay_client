import 'dart:convert';

class UserCredentials {
  String username;
  String password;

  UserCredentials(this.username, this.password);

  UserCredentials fromJson(Map<String, dynamic> json) {
    String username = json['username'];
    String password = json['password'];
    UserCredentials credentials = UserCredentials(username, password);
    return credentials;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {'username': username, 'password': password};

    return json;
  }

  getAccessToken() {
    String accessToken = base64.encode(utf8.encode("$username:$password"));
    return accessToken;
  }
}
