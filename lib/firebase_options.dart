// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAI-bd-bv0xPGPcQqIU1sTIfgngkgRwNLY',
    appId: '1:788980587447:web:632f5c25772b268e3d6632',
    messagingSenderId: '788980587447',
    projectId: 'soi-im-okay',
    authDomain: 'soi-im-okay.firebaseapp.com',
    storageBucket: 'soi-im-okay.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDLyfp1bdXaI89rbUGzsHefVPgerXID0XI',
    appId: '1:788980587447:android:8940247d9cc15e953d6632',
    messagingSenderId: '788980587447',
    projectId: 'soi-im-okay',
    storageBucket: 'soi-im-okay.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAX23fg56QUKjS0v4IYpD15g881YK4rL0E',
    appId: '1:788980587447:ios:ed90f2a43ddae04d3d6632',
    messagingSenderId: '788980587447',
    projectId: 'soi-im-okay',
    storageBucket: 'soi-im-okay.appspot.com',
    iosBundleId: 'com.example.imOkayClient',
  );
}
