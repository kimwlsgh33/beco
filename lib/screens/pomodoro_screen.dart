import 'dart:async';

import 'package:beco/cubits/auth_cubit.dart';
import 'package:beco/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PomodoroScreen extends StatefulWidget {
  final _pomodoroTime;
  const PomodoroScreen(
    this._pomodoroTime, {
    super.key,
  });
  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  int totalPomodoros = 0; // TODO : add to database
  late int totalSeconds;
  late Timer timer; // late keyword is used to initialize the variable later
  bool isRunning = false;

  @override
  void initState() {
    super.initState();
    totalSeconds = widget._pomodoroTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kakaoBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Text(
                  format(totalSeconds),
                  style: const TextStyle(
                    color: kakaoWhite,
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: Center(
                child: IconButton(
                  iconSize: 100,
                  color: kakaoWhite,
                  onPressed: isRunning ? onPausePressed : onStartPressed,
                  icon: Icon(
                    isRunning ? Icons.pause_rounded : Icons.play_circle_rounded,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: kakaoSecondaryColor,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(width: 70),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '오늘의 Pomodoro',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .color,
                                ),
                              ),
                              Text(
                                '$totalPomodoros',
                                style: const TextStyle(
                                  fontSize: 60,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            iconSize: 50,
                            color: Theme.of(context).backgroundColor,
                            onPressed: onResetPressed,
                            icon: const Icon(Icons.replay_rounded),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split('.').first.substring(2, 7);
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onResetPressed() {
    timer.cancel();
    setState(() {
      totalSeconds = context.read<AuthCubit>().state.focusTime;
      isRunning = false;
    });
  }

  void onStartPressed() {
    // periodic method is used to call a function repeatedly ( every 1 second in this case )
    timer = Timer.periodic(const Duration(seconds: 1), onTick);
    setState(() {
      isRunning = true;
    });
  }

  void onTick(Timer timer) {
    setState(() {
      if (totalSeconds > 0) {
        totalSeconds--;
      } else {
        timer.cancel();
        totalPomodoros++;
        totalSeconds = context.read<AuthCubit>().state.focusTime;
        isRunning = false;
      }
    });
  }
}
