import 'package:flutter_bloc/flutter_bloc.dart';

// 실제 사용자가 집중하는 시간을 측정하는 클래스
class PomoCubit extends Cubit<int> {
  PomoCubit() : super(100);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
  void reset(focusTime) => emit(focusTime);

  @override
  void onChange(Change<int> change) {
    print(change);
    super.onChange(change);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
    super.onError(error, stackTrace);
  }
}
