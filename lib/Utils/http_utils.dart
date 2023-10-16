import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:im_okay_client/Models/user.dart';
import 'package:http/http.dart' as http;
import 'package:im_okay_client/Utils/storage_utils.dart';

class HttpUtils {
  static const String _localDomain = "http://localhost";
  static const String _localPort = "5129";
  static const String _serverDomain = "http://20.217.26.29";
  static const String _serverPort = "80";
  static bool _isProduction = const bool.fromEnvironment('dart.vm.product');

  static Uri composeUri(String endpoint) {
    _isProduction = false;
    String domain = _isProduction ? _serverDomain : _localDomain;
    String port = _isProduction ? _serverPort : _localPort;
    String url = "$domain:$port/api/login/$endpoint";
    Uri uri = Uri.parse(url);
    return uri;
  }

  static Future<bool> reportOkay() async {
    Uri uriLogin = composeUri("report");
    String? accessToken = await StorageUtils.fetchAccessToken();
    if (accessToken == null) {
      return false;
    }

    Map<String, String> headers = {'Authorization': accessToken};
    Response response = await http.get(uriLogin, headers: headers);

    return response.statusCode == HttpStatus.ok;
  }

  static Future<bool> loginAndStoreCredentials(
      String username, String password) async {
    Uri uri = composeUri('');
    String accessToken = User.generateAccessToken(username, password);
    var headers = _getAuthorizationHeader(accessToken);
    Response response = await http.get(uri, headers: headers);
    if (response.statusCode != HttpStatus.ok) {
      return false;
    }

    User? user = User.fromJson(json.decode(response.body));
    if (user != null) {
      StorageUtils.storeUser(user);
    }
    StorageUtils.storeAccessToken(accessToken);
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

  static Future<List<User>> getOtherUsers() async {
    Uri uri = composeUri("status");
    String? accessToken = await StorageUtils.fetchAccessToken();
    if (accessToken == null) {
      return List.empty();
    }

    var headers = _getAuthorizationHeader(accessToken);
    Response response = await http.get(uri, headers: headers);
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
