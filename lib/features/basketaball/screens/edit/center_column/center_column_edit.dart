import 'package:flutter/material.dart';

import 'period_edit.dart';
import 'team_column_edit.dart';
import 'team_falls.dart';
import 'timer_edit.dart';

class CenterColumnEdit extends StatelessWidget {
  const CenterColumnEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //teams,period
        Expanded(
          flex: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Expanded(child: TeamColumnEdit(team: 1)),
              Flexible(child: PeriodEdit()),
              Expanded(child: TeamColumnEdit(team: 2)),
            ],
          ),
        ),
        //timer
        Expanded(flex: 3, child: TimerEdit()),
        //falls
        Expanded(
          flex: 1,
          child: Row(
            children: const [
              Expanded(child: TeamFalls(team: 1)),
              Expanded(child: TeamFalls(team: 2)),
            ],
          ),
        ),
      ],
    );
  }
}
