import 'package:beco/providers/user_provider.dart';
import 'package:beco/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    // Provider.of(context) : context를 통해 Provider를 가져옴
    UserProvider _userProvider = Provider.of(context, listen: false);
    // 저장된 유저 정보를 가져오는 메소드
    await _userProvider.refreshUser();
  }

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
