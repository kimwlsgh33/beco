import 'package:beco/utils/global_variables.dart';
import 'package:flutter/material.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget webScreen;
  final Widget mobileScreen;

  const ResponsiveLayout({
    super.key,
    required this.webScreen,
    required this.mobileScreen,
  });

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > webScreenSize) {
          // web 화면
          return widget.webScreen;
        }
        // 모바일 화면
        return widget.mobileScreen;
      },
    );
  }
}
