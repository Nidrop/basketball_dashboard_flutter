import 'package:flutter/material.dart';
import 'package:wheel_chooser/wheel_chooser.dart';

class TimerDialog extends StatefulWidget {
  final DateTime time;
  final void Function(DateTime) onAccept;

  const TimerDialog({super.key, required this.time, required this.onAccept});

  @override
  State<TimerDialog> createState() => _TimerDialogState();
}

class _TimerDialogState extends State<TimerDialog> {
  final double height = 280;
  final double width = 380;

  late DateTime resTime;
  int firstDigitOfMinute = 0;
  int secondDigitOfMinute = 0;
  int firstDigitOfSecond = 0;
  int secondDigitOfSecond = 0;
  int digitOfMillisecond = 0;

  @override
  void initState() {
    super.initState();

    resTime = widget.time;
    firstDigitOfMinute = resTime.minute % 10;
    secondDigitOfMinute = (resTime.minute >= 10) ? resTime.minute ~/ 10 : 0;
    firstDigitOfSecond = resTime.second % 10;
    secondDigitOfSecond = (resTime.second >= 10) ? resTime.second ~/ 10 : 0;
    digitOfMillisecond =
        (resTime.millisecond >= 100) ? resTime.millisecond ~/ 100 : 0;
  }

  @override
  Widget build(BuildContext context) {
    final double wheelHeight = height / 1.5;

    return Dialog(
      child: Container(
        height: height,
        width: width,
        margin: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Flexible(
                flex: 1,
                child: Center(
                    child: Text(
                  "Таймер:",
                  style: TextStyle(fontSize: 20),
                ))),
            Expanded(
              flex: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(border: Border.all()),
                      child: WheelChooser.integer(
                        listHeight: wheelHeight,
                        onValueChanged: (v) => secondDigitOfMinute = v,
                        maxValue: 9,
                        minValue: 0,
                        initValue: secondDigitOfMinute,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(border: Border.all()),
                      child: WheelChooser.integer(
                        listHeight: wheelHeight,
                        onValueChanged: (v) => firstDigitOfMinute = v,
                        maxValue: 9,
                        minValue: 0,
                        initValue: firstDigitOfMinute,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      ":",
                      style: TextStyle(fontSize: height / 6),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(border: Border.all()),
                      child: WheelChooser.integer(
                        listHeight: wheelHeight,
                        onValueChanged: (v) => secondDigitOfSecond = v,
                        maxValue: 5,
                        minValue: 0,
                        initValue: secondDigitOfSecond,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(border: Border.all()),
                      child: WheelChooser.integer(
                        listHeight: wheelHeight,
                        onValueChanged: (v) => firstDigitOfSecond = v,
                        maxValue: 9,
                        minValue: 0,
                        initValue: firstDigitOfSecond,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      ".",
                      style: TextStyle(fontSize: height / 6),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(border: Border.all()),
                      child: WheelChooser.integer(
                        listHeight: wheelHeight,
                        onValueChanged: (v) => digitOfMillisecond = v,
                        maxValue: 9,
                        minValue: 0,
                        initValue: digitOfMillisecond,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Закрыть")),
                  ElevatedButton(
                      onPressed: () {
                        int mil = digitOfMillisecond * 100;
                        int sec = secondDigitOfSecond * 10 + firstDigitOfSecond;
                        int min = secondDigitOfMinute * 10 + firstDigitOfMinute;
                        resTime = DateTime.fromMillisecondsSinceEpoch(
                            mil + sec * 1000 + min * 60 * 1000);
                        widget.onAccept(resTime);
                        Navigator.of(context).pop();
                      },
                      child: const Text("Принять")),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
