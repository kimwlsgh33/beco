import 'dart:async';
import 'package:beco/cubits/pomo_cubit.dart';
import 'package:beco/cubits/pomodoro_cubit.dart';
import 'package:beco/resources/pomo_methods.dart';

import '../cubits/auth_cubit.dart';
import '../resources/firestore_methods.dart';
import '../utils/colors.dart';
import '../widgets/showcases/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showcaseview/showcaseview.dart';

class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({
    super.key,
  });
  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  final GlobalKey _key1 = GlobalKey();
  final GlobalKey _key2 = GlobalKey();
  final GlobalKey _key3 = GlobalKey();
  final GlobalKey _key4 = GlobalKey();

  int totalPomodoros = 0; // TODO : add to database
  late Timer timer; // late keyword is used to initialize the variable later
  bool isRunning = false, isFocus = true;

  @override
  void initState() {
    super.initState();
    PomoMethods().getPomodoros(FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.info),
          onPressed: () {
            ShowCaseWidget.of(context)
                .startShowCase([_key1, _key2, _key3, _key4]);
          },
        ),
      ),
      backgroundColor: kakaoBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Showcase(
                  key: _key1,
                  title: '집중시간',
                  titleTextStyle: titleTextStyle,
                  description: '내가 얼마나 집중할수있는지 자동으로 측정해줍니다.',
                  descriptionAlignment: TextAlign.center,
                  targetPadding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  targetBorderRadius:
                      const BorderRadius.all(Radius.circular(20)),
                  child: Text(
                    format(context.read<PomoCubit>().state),
                    style: const TextStyle(
                      color: kakaoWhite,
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: Center(
                child: Showcase(
                  key: _key4,
                  title: '시작!',
                  titleTextStyle: titleTextStyle,
                  description: '이제 한번 시작해봅시다!',
                  targetShapeBorder: const CircleBorder(),
                  child: IconButton(
                    iconSize: 100,
                    color: kakaoWhite,
                    onPressed: isRunning ? onPausePressed : onStartPressed,
                    icon: Icon(
                      isRunning
                          ? Icons.pause_rounded
                          : Icons.play_circle_rounded,
                    ),
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
                                'Pomodoro',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .color,
                                ),
                              ),
                              Showcase(
                                key: _key2,
                                title: '오늘의 횟수',
                                titleTextStyle: titleTextStyle,
                                description: '오늘 몇번의 집중을 했는지 확인할 수 있습니다.',
                                targetPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                targetBorderRadius:
                                    const BorderRadius.all(Radius.circular(40)),
                                child: Text(
                                  '$totalPomodoros',
                                  style: const TextStyle(
                                    fontSize: 60,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Showcase(
                            key: _key3,
                            title: '리셋',
                            titleTextStyle: titleTextStyle,
                            description: '타이머를 초기화합니다. 저장되지 않으니 주의하세요.',
                            targetShapeBorder: const CircleBorder(),
                            child: IconButton(
                              iconSize: 50,
                              color: Theme.of(context).primaryColor,
                              onPressed: onResetPressed,
                              icon: const Icon(Icons.replay_rounded),
                            ),
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
    context.read<PomoCubit>().reset(
          context.read<PomodoroCubit>().state.focusTime,
        );
    setState(() {
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

  void updateTotalFocus() async {
    final log = await PomoMethods().getTodaysLog();
    if (!mounted) return;
    if (log.logId == "") {
      print('no log');
      PomoMethods().addPomoLog(
        uid: FirebaseAuth.instance.currentUser!.uid,
        totalFocus: context.read<AuthCubit>().state.focusTime,
      );
    } else {
      print('log exists');
      FirestoreMethods().updatePomoLog(
        uid: FirebaseAuth.instance.currentUser!.uid,
        time: context.read<AuthCubit>().state.focusTime,
        isFocus: isFocus,
      );
    }
  }

  void onTick(Timer timer) {
    if (context.read<PomoCubit>().state > 0) {
      context.read<PomoCubit>().decrement();
    } else {
      if (isFocus) {
        isFocus = false;
      } else {
        isFocus = true;
      }
      updateTotalFocus();
      onResetPressed();
    }
    setState(() {});
  }
}
