import 'dart:convert';
import 'dart:js_interop_unsafe';

import 'package:im_okay_client/Models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageUtils {
  static const String _accessTokenStorageKey = "accessToken";
  static const String _userStorageKey = "user";

  static Future<void> storeAccessToken(String accessToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenStorageKey, accessToken);
  }

  static Future<void> storeUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    String jsonUser = json.encode(user);
    await prefs.setString(_userStorageKey, jsonUser);
  }

  static Future<String?> fetchAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString(_accessTokenStorageKey);
    return accessToken;
  }

  static Future<User?> fetchUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString(_userStorageKey);
    if (userJson == null) {
      return null;
    }
    User user = User.fromJson(json.decode(userJson));
    return user;
  }

  static Future<void> removeCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_accessTokenStorageKey);
    prefs.remove(_userStorageKey);
  }
}
