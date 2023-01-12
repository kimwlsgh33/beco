import 'package:beco/models/user.dart';
import 'package:beco/resources/auth_method.dart';
import 'package:flutter/material.dart';

// ChangeNotifier : 상태를 전역으로 관리하기 위해 사용
class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethod _authMethod = AuthMethod();

  // define getter
  User get getUser => _user!;

  // 저장된 유저 정보를 가져오는 메소드
  Future<void> refreshUser() async {
    User user = await _authMethod.getCurrentUser();
    _user = user;
    // notifyListeners() : 상태가 변경되었음을 알림
    notifyListeners();
  }
}
