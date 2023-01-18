import 'package:beco/models/pomodoro.dart';
import 'package:beco/resources/pomo_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class ShowCaseScreen extends StatelessWidget {
  const ShowCaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      builder: Builder(
        builder: (context) => const MainScreen(),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey _showCaseKey = GlobalKey();
  final GlobalKey _showCaseKey2 = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            ShowCaseWidget.of(context)
                .startShowCase([_showCaseKey, _showCaseKey2]);
          },
        ),
        title: const Text('ShowCase Demo'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              Showcase(
                key: _showCaseKey,
                description: "This is a button",
                // targetShapeBorder: const CircleBorder(),
                targetPadding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                tooltipBackgroundColor: Colors.indigo,
                descTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
                overlayOpacity: 0.5,
                overlayColor: Colors.black,
                child: ElevatedButton(
                  onPressed: () async {
                    Pomodoro pomo = await PomoMethods()
                        .getPomodoros(FirebaseAuth.instance.currentUser!.uid);
                    print(pomo.toString());
                  },
                  child: const Text("Button"),
                ),
              ),
              Showcase(
                key: _showCaseKey2,
                title: "This is a Text",
                description: "This is a Text",
                child: Text(
                  'This is a sample text',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
