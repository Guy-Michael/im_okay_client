import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:im_okay/Services/API%20Services/User%20Authentication%20Service/user_authentication_api_service.dart';
import 'package:im_okay/Services/router_service.dart';
import 'package:im_okay/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  FirebaseMessaging.instance.requestPermission();
  await FirebaseMessaging.instance.setAutoInitEnabled(true);

  if (kDebugMode) {
    try {
      debugPrint("Launching authentication emulator");
      await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  FirebaseAuth.instance.authStateChanges().listen((User? user) async {
    if (user == null) {
      FirebaseMessaging.instance.deleteToken();
    } else {
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
    debugShowCheckedModeBanner: false,
    locale: const Locale('he', 'IL'),
    supportedLocales: const [Locale('he', 'IL')],
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    routerConfig: globalRouter,
  ));
}
