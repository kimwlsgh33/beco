import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker _picker = ImagePicker();

  XFile? _file = await _picker.pickImage(source: source);

  if (_file != null) {
    // dart.io의 File 클래스를 사용하여 이미지 파일을 읽지않음 ( web 환경에서는 dart.io가 지원되지 않음 )
    return await _file.readAsBytes();
  }
  print("No image selected");
}

// 알림을 보내는 기능 ( 자주 사용하므로 따로 빼놓음 )
showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}
