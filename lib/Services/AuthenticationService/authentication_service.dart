import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:im_okay/Enums/endpoint_enums.dart';
import 'package:im_okay/Models/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:im_okay/Services/AuthenticationService/i_authentication_service.dart';
import 'package:im_okay/Routers/global_router.dart';
import 'package:im_okay/Services/ContactsService/i_contacts_service.dart';
import 'package:im_okay/Services/service_injector.dart';
import 'package:im_okay/Utils/Consts/consts.dart';
import 'package:im_okay/Utils/encryption_utils.dart';
import 'package:im_okay/Utils/http_utils.dart';

class AuthenticationService implements IAuthenticationService {
  late final IContactsService _contactsService;

  AuthenticationService() {
    _contactsService = serviceInjector.get<IContactsService>();
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'openid',
      'profile',
    ],
  );

  @override
  Future<String> getFirebaseAuthToken({bool forceRefresh = true}) async {
    // return cacheService.getAuthToken() ?? '';
    if (auth.FirebaseAuth.instance.currentUser == null) {
      // await signOut();
      return '';
    }

    return (await auth.FirebaseAuth.instance.currentUser!.getIdToken())!;
  }

  @override
  Future<AppUser?> get appUser async => await fetchUser();

  @override
  Future<bool> registerNewUser(UserCredential credentials) async {
    String endpoint = AuthController.registerEndpoint.endpoint;
    Map<String, dynamic> profile = credentials.additionalUserInfo!.profile!;

    //TODO: Remove generation of phone numbers and use actual user phone number.
    Random random = Random();
    String tempPhoneNumber = "0" + List.generate(9, (index) => random.nextInt(10)).join('');
    tempPhoneNumber = _contactsService.normalizePhoneNumber(tempPhoneNumber);
    // tempPhoneNumber = EncryptionUtils.encrypt(tempPhoneNumber);

    try {
      AppUser user = AppUser(
        firstName: profile['given_name'],
        lastName: profile['family_name'],
        imageUrl: profile['picture'],
        lastSeen: 0,
        lastAlertTime: 0,
        phoneNumber: tempPhoneNumber,
      );

      Map<String, dynamic> body = user.toJson();
      await HttpUtils.post(endpoint: endpoint, body: body);
    } catch (e) {
      return false;
    }

    return true;
  }

  @override
  Future<AppUser?> fetchUser() async {
    String endpoint = AuthController.fetchUserEndpoint.endpoint;

    try {
      String userJson = await HttpUtils.get(endpoint: endpoint);
      AppUser user = AppUser.fromJson(jsonDecode(userJson));
      return user;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> deleteSignedInUserAndSignOut() async {
    String endpoint = AuthController.deleteUser.endpoint;

    bool deletedSuccessfully = await HttpUtils.delete(endpoint: endpoint);
    await signOut();
  }

  @override
  Future<bool> registerOrSignIn() async {
    UserCredential? cred = await signIn();
    if (cred == null) {
      return false;
    }

    bool authenticationSuccessful = false;
    bool isNewUser = cred.additionalUserInfo?.isNewUser ?? false;
    if (isNewUser) {
      await registerNewUser(cred);
      authenticationSuccessful = true;
    } else {
      AppUser? user = await fetchUser();
      if (user != null) {
        authenticationSuccessful = true;
      } else {
        await registerNewUser(cred);
      }
    }

    return authenticationSuccessful;
  }

  @override
  Future<UserCredential?> signIn() async {
    await _googleSignIn.signOut();
    GoogleSignInAccount? user = await _googleSignIn.signIn();

    GoogleSignInAuthentication? auth = await user?.authentication;

    if (auth == null) {
      return null;
    }

    final credentials = GoogleAuthProvider.credential(idToken: auth.idToken);
    UserCredential? firebaseCreds = await FirebaseAuth.instance.signInWithCredential(credentials);

    return firebaseCreds;
  }

  @override
  Future<void> signOut() async {
    await auth.FirebaseAuth.instance.signOut();
    globalRouter.replace(Routes.auth.authRedirectPage);
  }
}
