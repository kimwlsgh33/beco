import 'package:beco/cubits/auth_cubit.dart';
import 'package:beco/cubits/feed_cubit.dart';
import 'package:beco/cubits/wallet_cubit.dart';
import 'package:beco/responsive/mobile_screen_layout.dart';
import 'package:beco/responsive/responsive_layout_screen.dart';
import 'package:beco/responsive/web_screen_layout.dart';
import 'package:beco/screens/login_screen.dart';
import 'package:beco/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  // runApp(CounterApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // MultiProvider : 여러개의 Provider를 한번에 사용할 수 있게 해줌
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
          lazy: false,
        ),
        BlocProvider<FeedCubit>(
          create: (context) => FeedCubit(),
        ),
        BlocProvider<WalletCubit>(
          create: (context) => WalletCubit(),
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
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                body: Center(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'Loading...',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              if (snapshot.hasData) {
                context.read<AuthCubit>().refreshUser();
                return BlocProvider.value(
                  value: BlocProvider.of<AuthCubit>(context),
                  child: const ResponsiveLayout(
                    webScreen: WebScreenLayout(),
                    mobileScreen: MobileScreenLayout(),
                  ),
                );
              } else {
                return const LoginScreen();
              }
            }
          },
        ),
      ),
    );
  }
}
