import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/foundation.dart';
import 'package:im_okay/Models/user.dart';
import 'package:http/http.dart' as http;

enum AuthController {
  route('auth'),
  registerEndpoint('register'),
  validateEndpoint('validate'),
  registerFcmToken('store-token');

  final String value;
  const AuthController(this.value);
  String get endpoint {
    return '$route/$value';
  }
}

enum UsersController {
  route('users'),
  fullUserDataEndpoint('full-user-data'),
  findFriendsEndpoint('find-friends'),
  reportEndpoint('report'),
  friendsStatusEndpoint('friends-status'),
  addFriendsEndpoint('add-friend'),
  getFriendRequests('get-requests');

  final String value;
  const UsersController(this.value);
  String get endpoint => '${route.value}/$value';
}

class HttpUtils {
  static const String _localDomain = "http://localhost";
  static const String _localPort = "5129";
  static const String _serverDomain = "http://20.217.26.29";
  static const String _serverPort = "80";
  // static const bool _isProduction = kReleaseMode;
  static const bool _isProduction = true;

  static Uri composeUri({required String route, required String endpoint}) {
    String domain = _isProduction ? _serverDomain : _localDomain;
    String port = _isProduction ? _serverPort : _localPort;
    String url = "$domain:$port/$route/$endpoint";
    Uri uri = Uri.parse(url);
    return uri;
  }

  static Uri composeUri2({required String endpoint}) {
    String domain = _isProduction ? _serverDomain : _localDomain;
    String port = _isProduction ? _serverPort : _localPort;
    String url = "$domain:$port/$endpoint";
    Uri uri = Uri.parse(url);
    return uri;
  }

  static Future<bool> validateLogin(
      {required String username, required String password}) async {
    auth.UserCredential credentials = await auth.FirebaseAuth.instance
        .signInWithEmailAndPassword(email: username, password: password);

    var token = await credentials.user?.getIdToken();
    Uri uri = composeUri(
        route: AuthController.route.value,
        endpoint: AuthController.validateEndpoint.value);

    var headers = _getHeaders();
    String body = json.encode({'token': token});
    http.Response response = await http.post(uri, body: body, headers: headers);

    if (response.statusCode != 200) {
      return false;
    }

    return true;
  }

  static Future<bool> validateLoginByUid(
      {required String uid, required String authToken}) async {
    Uri uri = composeUri(
        route: AuthController.route.value,
        endpoint: AuthController.validateEndpoint.value);

    var headers = _getHeaders();
    String body = json.encode({'token': authToken});
    http.Response response = await http.post(uri, body: body, headers: headers);

    if (response.statusCode != 200) {
      return false;
    }

    return true;
  }

  static Future<void> registerNewUser({
    required String authToken,
    required User user,
  }) async {
    Uri uri = composeUri(
        route: AuthController.route.value,
        endpoint: AuthController.registerEndpoint.value);

    var headers = _getHeaders();
    String body = json.encode({'authToken': authToken, 'user': user});

    http.Response response = await http.post(uri, body: body, headers: headers);

    if (response.statusCode == HttpStatus.ok) {
    } else {}
  }

  static Future<List<User>> queryFriends(String searchQuery) async {
    Uri uri = composeUri(
        route: UsersController.route.value,
        endpoint: UsersController.findFriendsEndpoint.value);

    var headers = _getHeaders();
    String body = json.encode({'query': searchQuery});
    http.Response response = await http.post(uri, headers: headers, body: body);

    if (response.statusCode != HttpStatus.ok) {
      throw Exception("could not execute query");
    }

    List<User> friends = List<dynamic>.from(json.decode(response.body))
        .map((e) => User.fromJson(e))
        .toList();
    return friends;
  }

  static Future<User> getFullLoggedInUserData() async {
    String? uid = auth.FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      throw Exception();
    }

    Uri uri = composeUri(
        route: UsersController.route.value,
        endpoint: UsersController.fullUserDataEndpoint.value);
    var headers = _getHeaders();
    String body = json.encode({'uid': uid});

    http.Response response = await http.post(uri, body: body, headers: headers);

    if (response.statusCode != HttpStatus.ok) {
      throw Exception();
    }

    User user = User.fromJson(json.decode(response.body));
    return user;
  }

  static void sendFriendRequestToUser({required User friend}) {
    Uri uri = composeUri(
        route: UsersController.route.value,
        endpoint: UsersController.addFriendsEndpoint.value);

    var headers = _getHeaders();
    String requestorUid = auth.FirebaseAuth.instance.currentUser!.uid;
    String body = json
        .encode({'requestorUid': requestorUid, 'friendEmail': friend.email});

    http.post(uri, body: body, headers: headers);
  }

  static Map<String, String> _getHeaders() {
    var headers = {HttpHeaders.contentTypeHeader: 'Application/json'};

    return headers;
  }

  static Future<void> storeFcmToken(String deviceToken) async {
    Uri uri = composeUri(
        route: AuthController.route.value,
        endpoint: AuthController.registerFcmToken.value);

    String? uid = auth.FirebaseAuth.instance.currentUser?.uid;
    debugPrint(uid);
    String body = json.encode({'uid': uid, 'deviceToken': deviceToken});
    http.Response response =
        await http.post(uri, body: body, headers: _getHeaders());

    if (response.statusCode != HttpStatus.ok) {
      //do something bad
    }

    //Be happy.
  }

  static Future<List<User>> getFriendRequests() async {
    Uri uri = composeUri(
        route: UsersController.route.value,
        endpoint: UsersController.getFriendRequests.value);

    var headers = _getHeaders();

    String? uid = auth.FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      return [];
    }

    String body = json.encode({'uid': uid});

    http.Response response = await http.post(uri, body: body, headers: headers);

    if (response.statusCode != HttpStatus.ok) {
      return [];
    }

    List<dynamic> list = json.decode(response.body);
    List<User> requestors =
        list.map((dynamic element) => User.fromJson(element)).toList();
    return requestors;
  }

  static String formatJsonBody(Map<String, Object> bodyMap) {
    String body = json.encode(bodyMap);
    return body;
  }

  static Future<String> post(
      {required String endpoint, required Map<String, Object> body}) async {
    String bodyString = formatJsonBody(body);
    var headers = _getHeaders();

    Uri uri = composeUri2(endpoint: endpoint);

    http.Response response =
        await http.post(uri, body: bodyString, headers: headers);

    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Request failed with status ${response.statusCode}');
    }

    return response.body;
  }
}
