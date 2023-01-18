import 'package:beco/screens/home_screen.dart';
import 'package:beco/utils/global_variables.dart';
import 'package:beco/utils/providers.dart';
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
      providers: blocProviders(context),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Beco',
        theme: darkTheme,
        home: const HomeScreen() 
      ),
    );
  }
}
