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
}

enum UsersController {
  route('users'),
  fullUserDataEndpoint('full-user-data'),
  findFriendsEndpoint('find-friends'),
  reportEndpoint('report'),
  friendsStatusEndpoint('friends-status'),
  addFriendsEndpoint('add-friend');

  final String value;
  const UsersController(this.value);
}

class HttpUtils {
  // static const String _localDomain = "http://localhost";
  static const String _localDomain = "http://192.168.174.138";
  static const String _localPort = "5129";
  static const String _serverDomain = "http://20.217.26.29";
  static const String _serverPort = "80";
  static const bool _isProduction = kReleaseMode;

  static Uri composeUri({required String route, required String endpoint}) {
    String domain = _isProduction ? _serverDomain : _localDomain;
    String port = _isProduction ? _serverPort : _localPort;
    String url = "$domain:$port/$route/$endpoint";
    Uri uri = Uri.parse(url);
    return uri;
  }

  static Future<bool> reportOkay() async {
    Uri uriLogin = composeUri(
        route: UsersController.route.value,
        endpoint: UsersController.reportEndpoint.value);

    var headers = _getHeaders();
    String? uid = auth.FirebaseAuth.instance.currentUser?.uid;
    String body = json.encode({'uid': uid});
    http.Response response =
        await http.post(uriLogin, body: body, headers: headers);

    return response.statusCode == HttpStatus.ok;
  }

  static Future<bool> validateLogin(
      {required String username, required String password}) async {
    auth.UserCredential credentials = await auth.FirebaseAuth.instance
        .signInWithEmailAndPassword(email: username, password: password);

    Uri uri = composeUri(
        route: AuthController.route.value,
        endpoint: AuthController.validateEndpoint.value);
    var token = await credentials.user?.getIdToken();

    var headers = _getHeaders();
    String body = json.encode({'token': token});
    http.Response response = await http.post(uri, body: body, headers: headers);

    if (response.statusCode != 200) {
      return false;
    }

    return true;
  }

  static Future<List<User>> getAllFriends() async {
    Uri uri = composeUri(
        route: UsersController.route.value,
        endpoint: UsersController.friendsStatusEndpoint.value);

    auth.User? user = auth.FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception();
    }

    String body = json.encode({'uid': user.uid});
    var headers = _getHeaders();
    debugPrint("sending to: ${uri.toString()}");

    http.Response response = await http.post(uri, body: body, headers: headers);
    debugPrint("Succeeded!");
    List temp = json.decode(response.body);
    List<User> users = temp.map((u) {
      return User.fromJson(u);
    }).toList();

    return users;
  }

  static Future<void> registerNewUser({
    required String deviceToken,
    required User user,
  }) async {
    Uri uri = composeUri(
        route: AuthController.route.value,
        endpoint: AuthController.registerEndpoint.value);

    var headers = _getHeaders();
    String body = json.encode({'deviceToken': deviceToken, 'user': user});

    http.Response response = await http.post(uri, body: body, headers: headers);

    if (response.statusCode == HttpStatus.ok) {
      debugPrint('registration successful! OMG!');
    } else {
      debugPrint('registration failed :(');
    }
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
    debugPrint(user.toString());
    debugPrint("reloading pleaseeee");
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
}
