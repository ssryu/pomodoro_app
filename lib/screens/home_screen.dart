import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const initialTimerSeconds = 1500; // 25 minutes
  int totalSeconds = initialTimerSeconds;
  int totalPomodoros = 0;
  bool isRunning = false;
  late Timer timer;

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        totalSeconds = initialTimerSeconds;
        totalPomodoros++;
        isRunning = false;
      });
      timer.cancel();
      return;
    }

    setState(() {
      totalSeconds--;
    });
  }

  void onStartPressed() {
    timer = Timer.periodic(
      const Duration(
        seconds: 1,
      ),
      onTick,
    );
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  String getFormattedTime() {
    String minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    String seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(children: [
        Flexible(
          flex: 1,
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Text(
              getFormattedTime(),
              style: TextStyle(
                color: Theme.of(context).cardColor,
                fontSize: 89,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Flexible(
          flex: 3,
          child: Center(
            child: IconButton(
              onPressed: isRunning ? onPausePressed : onStartPressed,
              icon: Icon(isRunning
                  ? Icons.pause_circle_outline
                  : Icons.play_circle_outline),
              iconSize: 120,
              color: Theme.of(context).cardColor,
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
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Pomodoros",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textTheme.headline1!.color,
                        ),
                      ),
                      Text(
                        "$totalPomodoros",
                        style: TextStyle(
                          fontSize: 58,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textTheme.headline1!.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
