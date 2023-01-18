import 'package:beco/screens/admins/main_admin.dart';
import 'package:beco/screens/kakao_screen.dart';
import 'package:beco/screens/pomodoro_screen.dart';
import 'package:beco/screens/profile_screen.dart';
import 'package:beco/screens/showcase_screen.dart';
import 'package:beco/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

List<Widget> homeScreenItems(BuildContext context) => [
      ShowCaseWidget(
        builder: Builder(builder: (context) => const PomodoroScreen()),
      ),
      const ShowCaseScreen(),
      const MainAdmin(),
      const TossScreen(),
      // FeedScreen(),
      // const SearchScreen(),
      // const AddPostScreen(),
      ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid),
    ];

List<BottomNavigationBarItem> mobileNavBarItems(page) => [
      BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
          color: page == 0 ? primaryColor : secondaryColor,
        ),
        backgroundColor: primaryColor,
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.search,
          color: page == 1 ? primaryColor : secondaryColor,
        ),
        backgroundColor: primaryColor,
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.add_circle_outline_rounded,
          color: page == 2 ? primaryColor : secondaryColor,
        ),
        backgroundColor: primaryColor,
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.favorite,
          color: page == 3 ? primaryColor : secondaryColor,
        ),
        backgroundColor: primaryColor,
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.person,
          color: page == 4 ? primaryColor : secondaryColor,
        ),
        backgroundColor: primaryColor,
      ),
    ];
