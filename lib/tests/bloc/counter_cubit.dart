import 'package:flutter_bloc/flutter_bloc.dart';

// Counter의 상태를 관리하는 Cubit
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0); // 초기값은 0

  // emit()을 통해 상태를 변경
  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}
