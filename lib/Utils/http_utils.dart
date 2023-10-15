import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:im_okay_client/Models/user.dart';
import 'package:http/http.dart' as http;
import 'package:im_okay_client/Utils/storage_utils.dart';

class HttpUtils {
  static const String _localDomain = "http://localhost";
  static const String _localPort = "5129";
  static const String _serverDomain = "http://20.217.28.18";
  static const String _serverPort = "5000";
  static const bool _isProduction = bool.fromEnvironment('dart.vm.product');

  static Uri composeUri(String endpoint) {
    String domain = _isProduction ? _serverDomain : _localDomain;
    String port = _isProduction ? _serverPort : _localPort;
    String url = "$domain:$port/api/login/$endpoint";
    Uri uri = Uri.parse(url);
    return Uri.parse(url);
  }

  static Future<void> reportOkay() async {
    Uri uriLogin = composeUri("/");
    String accessToken = User.generateAccessToken("guy", "12345");
    Map<String, String> headers = {'Authorization': accessToken};
    var response = await http.get(uriLogin, headers: headers);
    debugPrint(response.body);
  }

  static Future<bool> loginAndStoreCredentials(
      String username, String password) async {
    Uri uri = composeUri('');
    String accessToken = User.generateAccessToken(username, password);
    var headers = _getAuthorizationHeader(accessToken);
    Response response = await http.get(uri, headers: headers);
    if (response.statusCode != HttpStatus.ok) {
      debugPrint('Login failed!');
      return false;
    }

    StorageUtils.storeAccessToken(accessToken);
    debugPrint('Login succeggassful!');
    return true;
  }

  static Future<bool> loginWithAccessToken(String accessToken) async {
    Uri uri = composeUri('');
    var headers = _getAuthorizationHeader(accessToken);
    Response response = await http.get(uri, headers: headers);

    if (response.statusCode != 200) {
      return false;
    }

    return true;
  }

  static Future<bool> validateLoginOnStartup() async {
    String? accessToken = await StorageUtils.fetchAccessToken();
    if (accessToken == null) {
      return false;
    }

    bool loggedIn = await loginWithAccessToken(accessToken);
    return loggedIn;
  }

  static Future<List<User>> getAllUsers() async {
    Uri uri = composeUri("status");
    String? accessToken = await StorageUtils.fetchAccessToken();
    if (accessToken == null) {
      return List.empty();
    }

    var headers = _getAuthorizationHeader(accessToken);
    Response response = await http.get(uri, headers: headers);
    debugPrint(response.body);
    List temp = json.decode(response.body);
    List<User> users = temp.map((u) {
      return User.fromJson(u);
    }).toList();

    return users;
  }

  static Map<String, String> _getAuthorizationHeader(String accessToken) {
    return {'Authorization': accessToken};
  }
}
