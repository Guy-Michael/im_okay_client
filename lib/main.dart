import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:im_okay/Services/API%20Services/User%20Authentication%20Service/user_authentication_api_service.dart';
import 'package:im_okay/Services/Notification%20Services/in_app_message_service.dart';
import 'package:im_okay/Services/router_service.dart';
import 'package:im_okay/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  FirebaseMessaging.instance.requestPermission();
  await FirebaseMessaging.instance.setAutoInitEnabled(true);

  if (!kReleaseMode) {
    try {
      debugPrint("Launching authentication emulator");
      await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    } catch (e) {
      debugPrint("Theres an error!");
    }
  }

  await FirebaseMessaging.instance.subscribeToTopic("users");
  FirebaseMessaging.onMessage.listen(
    (event) {
      InAppMessageService.showToast(message: event.data['name']);
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
