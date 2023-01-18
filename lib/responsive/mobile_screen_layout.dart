import 'package:beco/utils/nav_screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: onPageChanged,
        children: homeScreenItems(context),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 8.0),
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
        ),
        child: CupertinoTabBar(
          onTap: navigationTapped,
          // mobileBackgroundColor : flutter에서 제공하는 색상
          backgroundColor: Theme.of(context).backgroundColor,
          items: mobileNavBarItems(_page)
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  void navigationTapped(int page) {
    // pageController.jumpToPage(page);
    pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }
}
