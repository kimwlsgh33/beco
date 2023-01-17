import 'package:beco/models/user.dart' as model;
import 'package:beco/resources/auth_method.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<model.User> {
  final AuthMethod _authMethods = AuthMethod();
  AuthCubit()
      : super(
          const model.User(
            uid: '',
            email: '',
            username: '',
            photoUrl: '',
            bio: '',
            followers: [],
            following: [],
            focusTime: 0,
            restTime: 0,
          ),
        );

  model.User get user => state;

  void refreshUser() async {
    final model.User user = await _authMethods.getCurrentUser();
    emit(user);
  }
}
