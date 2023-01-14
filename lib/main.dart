import 'package:beco/providers/user_provider.dart';
import 'package:beco/responsive/mobile_screen_layout.dart';
import 'package:beco/responsive/responsive_layout_screen.dart';
import 'package:beco/responsive/web_screen_layout.dart';
import 'package:beco/screens/login_screen.dart';
import 'package:beco/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:beco/widgets/kakao_rooms.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    // MultiProvider : 여러개의 Provider를 한번에 사용할 수 있게 해줌
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider : 상태를 관리하는 클래스, create : 생성자
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Beco',
        // 애플리케이션의 테마.
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        // StreamBuilder는 스트림을 구독하고, 스트림의 데이터가 변경될 때마다 새로운 위젯을 생성
        home: StreamBuilder(
          // idTokenChanges : id, token, refresh token, access token 등의 변경을 감지
          // stateChanges : 로그인, 로그아웃, 회원가입 등의 유저상태 변경을 감지
          // authStateChanges : 로그인, 로그아웃 등의 유저 유무 상태 변경을 감지
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              // 로그인이 되어있는 상태
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                  mobileScreen: MobileScreenLayout(),
                  webScreen: WebScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                // 로그인이 안되어있는 상태
                return const LoginScreen();
              }
            } else {
              // 로그인 상태를 확인하는 중
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
