import 'package:beco/models/pomodoro.dart';
import 'package:beco/resources/pomo_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PomodoroCubit extends Cubit<Pomodoro> {
  // PomoCubit() : super(PomoMethods().getFocusTime());
  PomodoroCubit()
      : super(Pomodoro(
          pomodoroId: "",
          uid: "",
          focusTime: 1500,
          breakTime: 900,
        ));

  @override
  void onChange(Change<Pomodoro> change) {
    print(change);
    super.onChange(change);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
    super.onError(error, stackTrace);
  }

  void refresh()async {
    Pomodoro pomodoro = await PomoMethods().getPomodoros(FirebaseAuth.instance.currentUser!.uid);
    return emit(pomodoro);
  }
}
