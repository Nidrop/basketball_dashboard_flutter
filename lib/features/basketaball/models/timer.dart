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
    isPaused = true;
    periodTimer?.cancel();
    notifyListeners();
  }

  //todo
  void startOrStopTimeoutTimer() {
    if (isPeriod) {
      isPeriod = false;
      isPaused = true;

      periodTimer?.cancel();
      timeoutTime = DateTime.fromMillisecondsSinceEpoch(2 * 60 * 1000);
      timeoutTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        if (timeoutTime.millisecondsSinceEpoch == 0) {
          timeoutTimer?.cancel();
          notifyListeners();
          return;
        }
        timeoutTime = timeoutTime.add(const Duration(milliseconds: -100));
        notifyListeners();
      });
    } else {
      isPeriod = true;
      isPaused = true; //not necessary
      timeoutTimer?.cancel();
      notifyListeners();
    }
  }

  void startOrPausePeriodTimer() {
    if (isPaused) {
      isPaused = false;
      isPeriod = true;

      timeoutTimer?.cancel();
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
      isPeriod = true; //not necessary
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
