import 'package:beco/tests/test_widgets.dart';
import 'package:flutter/material.dart';

class NotiScreen extends StatelessWidget {
  const NotiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Card(
          child: testWrap(),
        ),
      ),
    );
  }
}
