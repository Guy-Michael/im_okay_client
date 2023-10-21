import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:im_okay_client/pages/hub_page.dart';
import 'package:im_okay_client/pages/login_page.dart';

class AuthRedirectPage extends StatelessWidget {
  const AuthRedirectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                debugPrint(snapshot.data!.toString());
                return const HubPage();
              }

              return const LoginPage();
            }));
  }
}
