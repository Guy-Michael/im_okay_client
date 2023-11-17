import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:im_okay/Services/API%20Services/User%20Authentication%20Service/user_authentication_api_service.dart';
import 'package:im_okay/Services/router_service.dart';
import 'package:im_okay/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  FirebaseMessaging.instance.requestPermission();
  await FirebaseMessaging.instance.setAutoInitEnabled(true);

  FirebaseAuth.instance.authStateChanges().listen((User? user) async {
    if (user == null) {
      FirebaseMessaging.instance.deleteToken();
      debugPrint('User is currently signed out!');
    } else {
      debugPrint('User is signed in!');

      String? deviceToken = await FirebaseMessaging.instance.getToken();

      if (deviceToken != null) {
        await UserAuthenticationApiService.storeFcmToken(deviceToken);
      }
    }
  });

  FirebaseMessaging.instance.onTokenRefresh.listen(
    (token) async {
      if (FirebaseAuth.instance.currentUser != null) {
        await UserAuthenticationApiService.storeFcmToken(token);
      }
    },
  );

  runApp(MaterialApp.router(
    routerConfig: globalRouter,
  ));
}
