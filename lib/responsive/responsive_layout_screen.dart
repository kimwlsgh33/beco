import 'package:beco/utils/dimensions.dart';
import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget webScreen;
  final Widget mobileScreen;

  const ResponsiveLayout({
    super.key,
    required this.webScreen,
    required this.mobileScreen,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > webScreenSize) {
          // web 화면
          return webScreen;
        }
        // 모바일 화면
        return mobileScreen;
      },
    );
  }
}
