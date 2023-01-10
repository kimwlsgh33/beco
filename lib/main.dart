import 'package:beco/firebase_options.dart';
import 'package:beco/responsive/mobile_screen_layout.dart';
import 'package:beco/responsive/responsive_layout_screen.dart';
import 'package:beco/responsive/web_screen_layout.dart';
import 'package:beco/screens/login_screen.dart';
import 'package:beco/screens/signup_screen.dart';
import 'package:beco/utils/colors.dart';
// import 'package:beco/widgets/kakao_rooms.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  const webOptions = FirebaseOptions(
    apiKey: "AIzaSyANg9_JwzvQD17M4WyOesyqN8TU1zpaqu4",
    appId: "1:388032541043:web:7fca6080a019c8fdda1506",
    messagingSenderId: "388032541043",
    projectId: "beco-6f572",
    // databaseURL: 'https://beco-1234567890.firebaseio.com',
    storageBucket: "beco-6f572.appspot.com",
  );

  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(options: webOptions);
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Beco',
      // 애플리케이션의 테마.
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      // home: const ResponsiveLayout(
      //   webScreenLayout: WebScreenLayout(),
      //   mobileScreenLayout: MobileScreenLayout(),
      // ),
      // home: LoginScreen(),
      home: SignupScreen(),
    );
  }
}
