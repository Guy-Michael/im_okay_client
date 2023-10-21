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
  static const String _serverDomain = "http://20.217.26.29";
  static const String _serverPort = "80";
  static const bool _isProduction = kReleaseMode;

  static Uri composeUri(String endpoint) {
    String domain = _isProduction ? _serverDomain : _localDomain;
    String port = _isProduction ? _serverPort : _localPort;
    String url = "$domain:$port/api/login/$endpoint";
    Uri uri = Uri.parse(url);
    return uri;
  }

  static Future<bool> reportOkay() async {
    Uri uriLogin = composeUri("report");
    String accessToken = await StorageUtils.fetchAccessToken();

    Map<String, String> headers = {'Authorization': accessToken};
    Response response = await http.get(uriLogin, headers: headers);

    return response.statusCode == HttpStatus.ok;
  }

  static Future<bool> loginAndStoreCredentials(
      String username, String password) async {
    Uri uri = composeUri('');
    String accessToken = User.generateAccessToken(username, password);
    var headers = await _getAuthorizationHeader(includeAuth: false);
    Response response = await http.get(uri, headers: headers);
    if (response.statusCode != HttpStatus.ok) {
      return false;
    }

    User user = User.fromJson(json.decode(response.body));
    StorageUtils.storeUser(user);

    StorageUtils.storeAccessToken(accessToken);
    return true;
  }

  static Future<bool> loginWithAccessToken(String accessToken) async {
    Uri uri = composeUri('');
    var headers = await _getAuthorizationHeader();
    Response response = await http.get(uri, headers: headers);

    if (response.statusCode != 200) {
      return false;
    }

    return true;
  }

  static Future<bool> validateLoginOnStartup() async {
    debugPrint('validating!');
    String accessToken = await StorageUtils.fetchAccessToken();

    bool loggedIn = await loginWithAccessToken(accessToken);
    return loggedIn;
  }

  static Future<List<User>> getOtherUsers() async {
    Uri uri = composeUri("statusAll");

    var headers = await _getAuthorizationHeader();
    Response response = await http.get(uri, headers: headers);
    List temp = json.decode(response.body);
    List<User> users = temp.map((u) {
      return User.fromJson(u);
    }).toList();

    return users;
  }

  static Future<void> registerNewUser(
      String name, String email, String password) async {
    Uri uri = composeUri('register');
    String body =
        json.encode({'username': email, 'nameHeb': name, 'password': password});
    Response response = await http.post(uri,
        body: body,
        headers: {HttpHeaders.contentTypeHeader: "application/json"});

    if (response.statusCode == HttpStatus.ok) {
      debugPrint('registration successful! OMG!');
    } else {
      debugPrint('registration failed :(');
    }
    return;
  }

  static Future<List<User>> queryFriends(String searchQuery) async {
    Uri uri = composeUri('query');
    var headers = await _getAuthorizationHeader();
    String body = json.encode({'query': searchQuery});
    Response response = await http.post(uri, headers: headers, body: body);

    if (response.statusCode != HttpStatus.ok) {
      throw Exception("could not execute query");
    }

    List<User> friends = json.decode(response.body);
    return friends;
  }

  static Future<Map<String, String>> _getAuthorizationHeader(
      {bool includeAuth = true}) async {
    var headers = {HttpHeaders.contentTypeHeader: 'Application/json'};

    if (includeAuth) {
      try {
        String accessToken = await StorageUtils.fetchAccessToken();
        headers[HttpHeaders.authorizationHeader] = accessToken;
      } catch (e) {
        debugPrint("no access token found.");
      }
    }

    return headers;
  }
}
