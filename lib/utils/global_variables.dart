import 'package:beco/cubits/auth_cubit.dart';
import 'package:beco/screens/admins/main_admin.dart';
import 'package:beco/screens/noti_screen.dart';
import 'package:beco/screens/pomodoro_screen.dart';
import 'package:beco/screens/kakao_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const webScreenSize = 600;

// 글로벌변수로, 화면을 지정
List<Widget> homeScreenItems(BuildContext context) => [
      PomodoroScreen(
        context.read<AuthCubit>().state.focusTime,
      ),
      MainAdmin(),
      TossScreen(),
      // FeedScreen(),
      // const SearchScreen(),
      // const AddPostScreen(),
      // ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid),
      Container(),
      Container(),
    ];
