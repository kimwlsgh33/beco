import 'package:beco/tests/bloc/counter_cubit.dart';
import 'package:beco/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Counter의 화면을 보여주는 위젯
class CounterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Counter')),
        // BockBuilder를 통해 CounterCubit의 상태를 구독
        body: BlocBuilder<CounterCubit, int>(
          builder: (context, count) => Center(
            child: Container(
            padding: const EdgeInsets.all(20),
              color: Colors.blueAccent,
              child: Text(
                '$count',
                style: const TextStyle(color: primaryColor),
              ),
            ),
          ),
        ),
        floatingActionButton: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () => context.read<CounterCubit>().increment(),
              child: const Icon(Icons.add),
            ),
            const SizedBox(height: 4),
            FloatingActionButton(
              onPressed: () => context.read<CounterCubit>().decrement(),
              child: const Icon(Icons.remove),
            ),
          ],
        ));
  }
}
