import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/timer.dart';
import 'timer_dialog.dart';

class TimerEdit extends StatelessWidget {
  const TimerEdit({
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TimerModel(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //buttons min
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer<TimerModel>(
                  builder: (context, timer, child) => ElevatedButton(
                    onPressed: () {
                      timer.setPeriodTime(
                          DateTime.fromMillisecondsSinceEpoch(5 * 60 * 1000));
                    },
                    child: const Text("5 минут"),
                  ),
                ),
                const SizedBox(width: 5),
                Consumer<TimerModel>(
                  builder: (context, timer, child) => ElevatedButton(
                    onPressed: () {
                      timer.setPeriodTime(
                          DateTime.fromMillisecondsSinceEpoch(10 * 60 * 1000));
                    },
                    child: const Text("10 минут"),
                  ),
                ),
                const SizedBox(width: 5),
                Consumer<TimerModel>(
                  builder: (context, timer, child) => ElevatedButton(
                    onPressed: () {
                      timer.setPeriodTime(
                          DateTime.fromMillisecondsSinceEpoch(12 * 60 * 1000));
                    },
                    child: const Text("12 минут"),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 3),
          //timer button
          const Expanded(child: TimerButton()),
          const SizedBox(height: 3),
          //start,stop
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer<TimerModel>(
                  builder: (context, timer, child) => ElevatedButton(
                    onPressed: () {
                      timer.startOrPausePeriodTimer();
                    },
                    child: Text((timer.isPaused) ? "Старт" : "Пауза"),
                  ),
                ),
                const SizedBox(width: 5),
                Consumer<TimerModel>(
                  builder: (context, timer, child) => ElevatedButton(
                    onPressed: () {
                      timer.stopPeriodTimer();
                    },
                    child: const Text("Стоп"),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          //timeout
          Flexible(
            child: Consumer<TimerModel>(
              builder: (context, timer, child) => ElevatedButton(
                onPressed: () {
                  timer.startOrStopTimeoutTimer();
                },
                child: const Text("Таймаут"),
              ),
            ),
          ),
          Flexible(
            child: Consumer<TimerModel>(
              builder: (context, timer, child) => Text(
                  (!timer.isPeriod)
                      ? "${timer.timeoutTime.minute < 10 ? '0${timer.timeoutTime.minute}' : timer.timeoutTime.minute}"
                          ":${timer.timeoutTime.second < 10 ? '0${timer.timeoutTime.second}' : timer.timeoutTime.second}"
                          ".${timer.timeoutTime.millisecond ~/ 100}"
                      : "",
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}

class TimerButton extends StatelessWidget {
  const TimerButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TimerModel>(
      builder: (context, timer, child) => FittedBox(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueGrey,
          ),
          onPressed: () {
            if (timer.isPaused) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return TimerDialog(
                      time: timer.periodTime,
                      onAccept: (changedTime) {
                        timer.setPeriodTime(changedTime);
                      },
                    );
                  });
            }
          },
          child: Text(
            "${timer.periodTime.minute < 10 ? '0${timer.periodTime.minute}' : timer.periodTime.minute}"
            ":${timer.periodTime.second < 10 ? '0${timer.periodTime.second}' : timer.periodTime.second}"
            ".${timer.periodTime.millisecond ~/ 100}",
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
