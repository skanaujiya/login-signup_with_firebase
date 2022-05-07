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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCqptC87UoYYBmzZ5EFNAbrl8FuofRx9eQ',
    appId: '1:309567334949:web:2df4f1db086f6f92016dcc',
    messagingSenderId: '309567334949',
    projectId: 'login-signup-app',
    authDomain: 'login-signup-app-e2543.firebaseapp.com',
    storageBucket: 'login-signup-app.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDoAPIzCo8811I8dpozvnRMUphp2a3Aip4',
    appId: '1:309567334949:android:5c14effed3bfea0a016dcc',
    messagingSenderId: '309567334949',
    projectId: 'login-signup-app',
    storageBucket: 'login-signup-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD0JPbQrtlHe6VvX8lVai26eN-CdoH2sUI',
    appId: '1:309567334949:ios:fad08a4333c8f103016dcc',
    messagingSenderId: '309567334949',
    projectId: 'login-signup-app',
    storageBucket: 'login-signup-app.appspot.com',
    iosClientId: '309567334949-k7hun6ji62a5rnbk6nak2m4aeopp00l8.apps.googleusercontent.com',
    iosBundleId: 'com.example.loginSignupAppWithScanFunction',
  );
}