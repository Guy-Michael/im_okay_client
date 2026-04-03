import 'package:firebase_auth/firebase_auth.dart';
import 'package:im_okay/Models/app_user.dart';

abstract class IAuthenticationService {
  Future<String> getFirebaseAuthToken({bool forceRefresh = true});

  Future<AppUser?> get appUser;

  Future<bool> registerNewUser(UserCredential credentials);

  Future<AppUser?> fetchUser();

  Future<void> deleteSignedInUserAndSignOut();

  Future<bool> registerOrSignIn();

  Future<UserCredential?> signIn();

  Future<void> signOut();
}
