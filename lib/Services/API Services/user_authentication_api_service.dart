import 'dart:convert';

import 'package:im_okay/Models/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:im_okay/Utils/http_utils.dart';

enum AuthController {
  route('auth'),
  registerEndpoint('register'),
  validateEndpoint('validate'),
  registerFcmToken('store-token'),
  getLoggedInUserData('full-user-data');

  final String value;
  const AuthController(this.value);
  String get endpoint {
    return '$route/$value';
  }
}

class UserAuthenticationApiService {
  static auth.User? get firebaseUser {
    return auth.FirebaseAuth.instance.currentUser;
  }

  static Future<User?> get appUser async {
    String endpoint = AuthController.getLoggedInUserData.endpoint;

    String? uid = firebaseUser?.uid;

    if (uid == null) {
      return null;
    }

    var body = {'uid': uid};

    String response = await HttpUtils.post(endpoint: endpoint, body: body);
    User user = User.fromJson((json.decode(response)));

    return user;
  }

  static Future<bool> registerNewUser({
    required String authToken,
    required User user,
  }) async {
    String endpoint = AuthController.registerEndpoint.endpoint;

    var body = {'authToken': authToken, 'user': user};

    try {
      await HttpUtils.post(endpoint: endpoint, body: body);
    } on Exception {
      return false;
    }

    return true;
  }
}
