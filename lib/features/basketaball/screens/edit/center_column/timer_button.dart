import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/timer.dart';
import 'timer_dialog.dart';

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
