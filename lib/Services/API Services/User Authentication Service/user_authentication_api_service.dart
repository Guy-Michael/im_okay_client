import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:im_okay/Enums/endpoint_enums.dart';
import 'package:im_okay/Models/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:im_okay/Utils/http_utils.dart';

class UserAuthenticationApiService {
  static auth.User? get firebaseUser {
    return auth.FirebaseAuth.instance.currentUser;
  }

  static Future<User?> get appUser async {
    String endpoint = AuthController.signedInUserData.endpoint;

    String? authToken = await firebaseUser?.getIdToken();

    if (authToken == null) {
      return null;
    }

    var body = {'authToken': authToken};

    String response = await HttpUtils.post(endpoint: endpoint, body: body);
    debugPrint(response);
    User user = User.fromJson((json.decode(response)));

    return user;
  }

  static Future<bool> registerNewUser({required String password, required User user}) async {
    String endpoint = AuthController.registerEndpoint.endpoint;

    auth.UserCredential credential;

    credential = await auth.FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: user.email, password: password);

    String authToken = (await credential.user?.getIdToken())!;

    var body = {'authToken': authToken, 'user': user};

    try {
      await HttpUtils.post(endpoint: endpoint, body: body);
    } on Exception {
      return false;
    } finally {
      auth.FirebaseAuth.instance.signOut();
    }

    return true;
  }

  static Future<bool> validateLoginAndGetUserData(
      {required String username, required String password}) async {
    auth.UserCredential credentials = await auth.FirebaseAuth.instance
        .signInWithEmailAndPassword(email: username, password: password);

    if (credentials.user == null) {
      throw Exception("User not registered");
    }

    String uri = AuthController.validateEndpoint.endpoint;

    var token = (await credentials.user!.getIdToken())!;
    var body = {'token': token};

    try {
      await HttpUtils.post(endpoint: uri, body: body);
    } catch (e) {
      return false;
    }

    return true;
  }

  static Future<void> storeFcmToken(String deviceToken) async {
    String endpoint = AuthController.registerFcmToken.endpoint;
    String? uid = auth.FirebaseAuth.instance.currentUser!.uid;

    var body = {'uid': uid, 'deviceToken': deviceToken};

    await HttpUtils.post(endpoint: endpoint, body: body);
  }

  static Future<void> deleteSignedInUser() async {
    String endpoint = AuthController.deleteUser.endpoint;

    User signedInUser = (await appUser)!;
    var body = {'email': signedInUser.email};

    await HttpUtils.post(endpoint: endpoint, body: body);
  }
}
