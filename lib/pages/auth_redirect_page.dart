import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:im_okay/Services/API%20Services/user_authentication_api_service.dart';
import 'package:im_okay/Utils/http_utils.dart';
import 'package:im_okay/pages/hub_page.dart';
import 'package:im_okay/pages/login_page.dart';

class AuthRedirectPage extends StatelessWidget {
  const AuthRedirectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(future: () async {
        auth.User? user = UserAuthenticationApiService.firebaseUser;

        if (user == null) {
          return false;
        }

        String authToken = (await user.getIdToken())!;
        String uid = user.uid;

        bool authenticated =
            await HttpUtils.validateLoginByUid(uid: uid, authToken: authToken);

        return authenticated;
      }(), builder: (context, snapshot) {
        return (snapshot.hasData && snapshot.data!)
            ? const HubPage()
            : const LoginPage();
      }),
      // body: StreamBuilder<User?>(
      //     stream: FirebaseAuth.instance.authStateChanges(),
      //     builder: (context, snapshot) {
      //       if (snapshot.hasData) {
      //         return const HubPage();
      //       }

      //       return const LoginPage();
      //     })
    );
  }
}
