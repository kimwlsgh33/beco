import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController controller;
  final bool isPass;
  final String hintText;
  final TextInputType inputType;

  const TextFieldInput({
    super.key,
    this.isPass = false,
    required this.hintText,
    required this.inputType,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    // OutlineInputBorder은 텍스트 필드의 외곽선을 정의하는 데 사용
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: inputType,
      obscureText: isPass, // 비밀번호 입력 시 true
    );
  }
}
