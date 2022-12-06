import 'dart:async';

import 'package:flutter/material.dart';

class TimerModel extends ChangeNotifier {
  bool isPeriod = true, isPaused = true;
  DateTime periodTime = DateTime.fromMillisecondsSinceEpoch(0);
  DateTime timeoutTime = DateTime.fromMillisecondsSinceEpoch(0);
  Timer? periodTimer;
  Timer? timeoutTimer;

  @override
  void dispose() {
    super.dispose();
  }

  void setPeriodTime(DateTime d) {
    periodTime = d;
    notifyListeners();
  }

  //todo
  void startOrStopTimeoutTime() {
    timeoutTime = DateTime.fromMillisecondsSinceEpoch(10 * 60 * 1000);
    notifyListeners();
  }

  void startOrPausePeriodTimer() {
    if (isPaused) {
      isPaused = false;

      periodTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        if (periodTime.millisecondsSinceEpoch == 0) {
          periodTimer?.cancel();
          isPaused = true;
          notifyListeners();
          return;
        }
        periodTime = periodTime.add(const Duration(milliseconds: -100));
        notifyListeners();
      });
    } else {
      isPaused = true;
      periodTimer?.cancel();
      notifyListeners();
    }
  }

  void stopPeriodTimer() {
    isPaused = true;
    periodTimer?.cancel();
    periodTime = DateTime.fromMillisecondsSinceEpoch(0);
    notifyListeners();
  }
}
