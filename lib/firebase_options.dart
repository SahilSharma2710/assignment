// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return macos;
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
    apiKey: 'AIzaSyD6vfyQR4OSAyR2kjyN6L44wqWeLExR0h0',
    appId: '1:718923088406:web:90f9797e433e5214592b37',
    messagingSenderId: '718923088406',
    projectId: 'miles-assignment',
    authDomain: 'miles-assignment.firebaseapp.com',
    storageBucket: 'miles-assignment.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCMk120pQK8a1dwh3Gw7wxV1YCV57PfgdI',
    appId: '1:718923088406:android:c790eb32513b38ec592b37',
    messagingSenderId: '718923088406',
    projectId: 'miles-assignment',
    storageBucket: 'miles-assignment.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCZP9SUEuv7KNDJHkcAGt6g9g0Ibn-6U9U',
    appId: '1:718923088406:ios:ed7a4b1e8ff15d0d592b37',
    messagingSenderId: '718923088406',
    projectId: 'miles-assignment',
    storageBucket: 'miles-assignment.firebasestorage.app',
    iosBundleId: 'com.example.milesAssignment',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCZP9SUEuv7KNDJHkcAGt6g9g0Ibn-6U9U',
    appId: '1:718923088406:ios:ed7a4b1e8ff15d0d592b37',
    messagingSenderId: '718923088406',
    projectId: 'miles-assignment',
    storageBucket: 'miles-assignment.firebasestorage.app',
    iosBundleId: 'com.example.milesAssignment',
  );
}
