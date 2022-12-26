import 'package:flutter/material.dart';

class CenterColumnView extends StatelessWidget {
  const CenterColumnView({Key? key}) : super(key: key);

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
              Expanded(child: TeamColumnView(team: 1)),
              Flexible(child: PeriodView()),
              Expanded(child: TeamColumnView(team: 2)),
            ],
          ),
        ),
        //timer
        const Expanded(flex: 3, child: TimerView()),
        //falls
        Expanded(
          flex: 1,
          child: Row(
            children: const [
              Expanded(child: TeamFallsView(team: 1)),
              Expanded(child: TeamFallsView(team: 2)),
            ],
          ),
        ),
      ],
    );
  }
}

class TeamColumnView extends StatelessWidget {
  const TeamColumnView({super.key, required this.team});

  final int team;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [Text("Команда"), Text("Страна"), Text("0"), Text("0")],
    );
  }
}

class PeriodView extends StatelessWidget {
  const PeriodView({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("0");
  }
}

class TimerView extends StatelessWidget {
  const TimerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("00:00.0"),
        Text("Таймаут:"),
        Text("0.0"),
      ],
    );
  }
}

class TeamFallsView extends StatelessWidget {
  const TeamFallsView({super.key, required this.team});

  final int team;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: (team == 1) ? Alignment.bottomLeft : Alignment.bottomRight,
        child: Text("0"));
  }
}
