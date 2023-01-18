import 'package:beco/cubits/auth_cubit.dart';
import 'package:beco/responsive/mobile_screen_layout.dart';
import 'package:beco/responsive/responsive_layout_screen.dart';
import 'package:beco/responsive/web_screen_layout.dart';
import 'package:beco/screens/loading_screen.dart';
import 'package:beco/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else {
          if (snapshot.hasData) {
            context.read<AuthCubit>().refreshUser();
            return const ResponsiveLayout(
              webScreen: WebScreenLayout(),
              mobileScreen: MobileScreenLayout(),
            );
          } else {
            return const LoginScreen();
          }
        }
      },
    );
  }
}
