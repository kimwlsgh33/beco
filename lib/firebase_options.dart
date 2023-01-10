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
    apiKey: 'AIzaSyANg9_JwzvQD17M4WyOesyqN8TU1zpaqu4',
    appId: '1:388032541043:web:e8dd51a9ff559b33da1506',
    messagingSenderId: '388032541043',
    projectId: 'beco-6f572',
    authDomain: 'beco-6f572.firebaseapp.com',
    storageBucket: 'beco-6f572.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCDYmSBW6kDWBu1ArTJWwBlrbU6WUqo5WY',
    appId: '1:388032541043:android:1354b18ac510929dda1506',
    messagingSenderId: '388032541043',
    projectId: 'beco-6f572',
    storageBucket: 'beco-6f572.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCqwgsPKcZss6hpNZ1tYq6-Km-INy5Pbo0',
    appId: '1:388032541043:ios:335c173c6b79f101da1506',
    messagingSenderId: '388032541043',
    projectId: 'beco-6f572',
    storageBucket: 'beco-6f572.appspot.com',
    iosClientId: '388032541043-p88lful8gts6vpgog1hfbfn4k7ta07qs.apps.googleusercontent.com',
    iosBundleId: 'com.example.beco',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCqwgsPKcZss6hpNZ1tYq6-Km-INy5Pbo0',
    appId: '1:388032541043:ios:335c173c6b79f101da1506',
    messagingSenderId: '388032541043',
    projectId: 'beco-6f572',
    storageBucket: 'beco-6f572.appspot.com',
    iosClientId: '388032541043-p88lful8gts6vpgog1hfbfn4k7ta07qs.apps.googleusercontent.com',
    iosBundleId: 'com.example.beco',
  );
}
