import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:im_okay_client/Services/router_service.dart';
import 'package:im_okay_client/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      debugPrint('User is currently signed out!');
    } else {
      debugPrint('User is signed in!');
    }
  });

  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

  runApp(MaterialApp.router(
    routerConfig: globalRouter,
  ));
}
