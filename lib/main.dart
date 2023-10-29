import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:im_okay/Services/router_service.dart';
import 'package:im_okay/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  FirebaseMessaging.onMessage.listen(
    (event) {
      debugPrint(event.data.toString());
    },
  );
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      debugPrint('User is currently signed out!');
    } else {
      debugPrint('User is signed in!');
    }
  });

  runApp(MaterialApp.router(
    routerConfig: globalRouter,
  ));
}
