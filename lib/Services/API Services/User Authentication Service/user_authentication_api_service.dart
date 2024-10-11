import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:im_okay/Enums/endpoint_enums.dart';
import 'package:im_okay/Models/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:im_okay/Utils/http_utils.dart';

class UserAuthenticationApiService {
  static auth.User? get firebaseUser {
    return auth.FirebaseAuth.instance.currentUser;
  }

  static Future<AppUser?> get appUser async {
    return AppUser(firstName: 'fake', lastName: 'created in auth service', email: "fake@fake.com");
  }

  static Future<bool> registerNewUser(UserCredential credentials) async {
    String endpoint = AuthController.registerEndpoint.endpoint;
    Map<String, dynamic> profile = credentials.additionalUserInfo!.profile!;

    Map<String, dynamic> body = AppUser(
            firstName: profile['given_name'],
            lastName: profile['family_name'],
            email: profile['email'],
            imageUrl: profile['picture'])
        .toJson();

    try {
      await HttpUtils.post(endpoint: endpoint, body: body);
    } catch (e) {
      return false;
    } finally {
      auth.FirebaseAuth.instance.signOut();
    }

    return true;
  }

  static Future<bool> login() async {
    auth.User? user = firebaseUser;
    if (user == null) {
      return false;
    }

    String endpoint = AuthController.loginEndpoint.endpoint;

    try {
      await HttpUtils.get(endpoint: endpoint);
    } catch (e) {
      return false;
    }

    return true;
  }

  static Future<void> deleteSignedInUser() async {
    String endpoint = AuthController.deleteUser.endpoint;

    AppUser signedInUser = (await appUser)!;
    var body = {'email': signedInUser.email};

    await HttpUtils.post(endpoint: endpoint, body: body);
  }

  static Future<bool> registerOrSignIn() async {
    await _googleSignIn.signOut();
    GoogleSignInAccount? account = await _googleSignIn.signIn();
    GoogleSignInAuthentication? auth = await account?.authentication;

    if (auth != null) {
      String? token = auth.idToken;

      final credential = GoogleAuthProvider.credential(
        idToken: token,
      );

      UserCredential? cred = await FirebaseAuth.instance.signInWithCredential(credential);

      bool authenticationSuccessful = false;
      bool isNewUser = cred.additionalUserInfo?.isNewUser ?? false;
      if (isNewUser) {
        authenticationSuccessful = await UserAuthenticationApiService.registerNewUser(cred);
      } else {
        authenticationSuccessful = await UserAuthenticationApiService.login();
      }

      return authenticationSuccessful;
    }

    return false;
  }

  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'openid',
      'profile',
    ],
  );
}
