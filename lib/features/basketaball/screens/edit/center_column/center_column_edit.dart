import 'package:basketball_dashboard_flutter/features/basketaball/models/period.dart';
import 'package:basketball_dashboard_flutter/features/basketaball/models/players.dart';
import 'package:basketball_dashboard_flutter/features/basketaball/models/teams.dart';
import 'package:basketball_dashboard_flutter/features/basketaball/screens/edit/center_column/timer_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/timer.dart';
import 'timer_button.dart';

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
            children: [
              Expanded(child: teamColumnEdit(team: 1)),
              Flexible(child: periodEdit()),
              Expanded(child: teamColumnEdit(team: 2)),
            ],
          ),
        ),
        //timer
        Expanded(flex: 3, child: timerEdit(context)),
        //falls
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Expanded(child: teamFalls(team: 1)),
              Expanded(child: teamFalls(team: 2)),
            ],
          ),
        ),
      ],
    );
  }

  //Methods

  Widget teamColumnEdit({int team = 0}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        //team
        Consumer<TeamsModel>(
          builder: (context, teams, child) => TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Команда",
            ),
            onChanged: (value) {
              teams.setName(team, value);
            },
          ),
        ),
        //country
        Consumer<TeamsModel>(
          builder: (context, teams, child) => TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Страна",
            ),
            onChanged: (value) {
              teams.setCountry(team, value);
            },
          ),
        ),
        //teamScore
        Column(
          children: [
            const Text("Cчет:"),
            Consumer<PlayersModel>(
              builder: (context, players, child) => Text(
                (team == 1)
                    ? players.leftScore.toString()
                    : players.rightScore.toString(),
                style:
                    const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        //timeouts
        Column(
          children: [
            const Text("Таймауты:"),
            Consumer<TeamsModel>(
              builder: (context, teams, child) => ElevatedButton(
                onPressed: () {
                  teams.addTimeout(team);
                },
                onLongPress: () {
                  teams.subTimeout(team);
                },
                child: Text((team == 1)
                    ? teams.leftTeam.timeouts.toString()
                    : teams.rightTeam.timeouts.toString()),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget periodEdit() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Consumer<PeriodModel>(
        builder: (context, period, child) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Период:"),
            ElevatedButton(
              onPressed: () {
                period.add();
              },
              onLongPress: () {
                period.sub();
              },
              child: Text(period.period.toString()),
            ),
          ],
        ),
      ),
    );
  }

  Widget timerEdit(BuildContext context) {
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

  Widget teamFalls({int team = 0}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 5),
      alignment: (team == 1) ? Alignment.bottomLeft : Alignment.bottomRight,
      child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        const Text("Фолы:"),
        Consumer<TeamsModel>(
          builder: (context, teams, child) => ElevatedButton(
            onPressed: () {
              teams.addFall(team);
            },
            onLongPress: () {
              teams.subFall(team);
            },
            child: Text((team == 1)
                ? teams.leftTeam.falls.toString()
                : teams.rightTeam.falls.toString()),
          ),
        ),
      ]),
    );
  }
}
