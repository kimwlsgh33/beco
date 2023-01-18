import 'package:flutter/material.dart';

class NotiScreen extends StatelessWidget {
  const NotiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF282A31),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            // child: testButtons(context)
            child: Container(),
          ),
        ),
      ),
    );
  }
}
