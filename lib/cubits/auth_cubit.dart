import 'package:beco/models/user.dart';
import 'package:beco/resources/auth_method.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<User> {
  final AuthMethod _authMethods = AuthMethod();
  AuthCubit() : super({} as User);

  User get user => state;

  void fetchUser() async {
    final User user = await _authMethods.getCurrentUser();
    emit(user);
  }
}
