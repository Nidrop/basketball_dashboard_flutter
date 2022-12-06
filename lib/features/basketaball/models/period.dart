import 'package:flutter/material.dart';

class PeriodModel extends ChangeNotifier {
  final int maxPeriods = 5;

  int period = 0;

  void add() {
    ++period;
    if (period > maxPeriods) {
      period = 0;
    }
    notifyListeners();
  }

  void sub() {
    --period;
    if (period < 0) {
      period = maxPeriods;
    }
    notifyListeners();
  }
}
