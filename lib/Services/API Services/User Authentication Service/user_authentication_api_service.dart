import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:im_okay/Enums/endpoint_enums.dart';
import 'package:im_okay/Exceptions/user_signed_out_exception.dart';
import 'package:im_okay/Models/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:im_okay/Services/router_service.dart';
import 'package:im_okay/Utils/Consts/consts.dart';
import 'package:im_okay/Utils/http_utils.dart';

class UserAuthenticationApiService {
  static Future<String> getFirebaseAuthToken({bool forceRefresh = true}) async {
    if (auth.FirebaseAuth.instance.currentUser == null) {
      throw UserSignedOutException();
    }

    return (await auth.FirebaseAuth.instance.currentUser!.getIdToken())!;
  }

  static Future<AppUser?> get appUser async => await fetchUser();

  static Future<bool> registerNewUser(UserCredential credentials) async {
    String endpoint = AuthController.registerEndpoint.endpoint;
    Map<String, dynamic> profile = credentials.additionalUserInfo!.profile!;

    try {
      AppUser user = AppUser(
          firstName: profile['given_name'],
          lastName: profile['family_name'],
          email: profile['email'],
          imageUrl: profile['picture'],
          lastSeen: 0);

      Map<String, dynamic> body = user.toJson();
      await HttpUtils.post(endpoint: endpoint, body: body);
    } catch (e) {
      return false;
    } finally {
      auth.FirebaseAuth.instance.signOut();
    }

    return true;
  }

  static Future<AppUser?> fetchUser() async {
    String endpoint = AuthController.fetchUserEndpoint.endpoint;

    // try {
    String userJson = await HttpUtils.get(endpoint: endpoint);
    AppUser user = AppUser.fromJson(jsonDecode(userJson));
    return user;
    // } catch (e) {

    //   return null;
    // }
  }

  static Future<void> deleteSignedInUserAndSignOut() async {
    String endpoint = AuthController.deleteUser.endpoint;

    bool deletedSuccessfully = await HttpUtils.delete(endpoint: endpoint);
    await signOut();
  }

  static Future<bool> registerOrSignIn() async {
    UserCredential? cred = await signIn();
    if (cred == null) {
      return false;
    }

    bool authenticationSuccessful = false;
    bool isNewUser = cred.additionalUserInfo?.isNewUser ?? false;
    if (isNewUser) {
      await UserAuthenticationApiService.registerNewUser(cred);
      authenticationSuccessful = true;
    } else {
      AppUser? user = await UserAuthenticationApiService.fetchUser();
      if (user != null) {
        authenticationSuccessful = true;
      }
    }

    return authenticationSuccessful;
  }

  static final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'openid',
      'profile',
    ],
  );

  static Future<UserCredential?> signIn() async {
    await googleSignIn.signOut();
    GoogleSignInAccount? user = await googleSignIn.signIn();

    GoogleSignInAuthentication? auth = await user?.authentication;

    if (auth == null) {
      return null;
    }

    final credentials = GoogleAuthProvider.credential(idToken: auth.idToken);
    UserCredential? firebaseCreds = await FirebaseAuth.instance.signInWithCredential(credentials);

    return firebaseCreds;
  }

  static Future<void> signOut() async {
    await auth.FirebaseAuth.instance.signOut();
    globalRouter.push(Routes.authRedirectPage);
  }
}
