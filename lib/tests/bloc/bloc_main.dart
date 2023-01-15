import 'package:beco/tests/bloc/counter_cubit.dart';
import 'package:beco/tests/bloc/counter_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // BlocProvider를 통해 CounterCubit을 하위 위젯들에게 제공
      home: BlocProvider(
        create: (_) => CounterCubit(),
        child: CounterView(),
      ),
    );
  }
}
