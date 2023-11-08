import 'dart:convert';
import 'package:im_okay/Models/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:im_okay/Utils/http_utils.dart';

enum AuthController {
  route('auth'),
  registerEndpoint('register'),
  validateEndpoint('validate'),
  registerFcmToken('store-token');

  final String value;
  const AuthController(this.value);
  String get endpoint {
    return '${route.value}/$value';
  }
}

class UserAuthenticationApiService {
  static auth.User? get firebaseUser {
    return auth.FirebaseAuth.instance.currentUser;
  }

  static Future<User?> get appUser async {
    String endpoint = UsersController.fullUserDataEndpoint.endpoint;

    String? authToken = await firebaseUser?.getIdToken();

    if (authToken == null) {
      return null;
    }

    var body = {'authToken': authToken};

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
}
