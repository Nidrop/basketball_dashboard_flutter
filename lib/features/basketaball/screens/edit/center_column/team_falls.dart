import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/teams.dart';

class TeamFalls extends StatelessWidget {
  const TeamFalls({
    Key? key,
    required this.team,
  }) : super(key: key);

  final int team;

  @override
  Widget build(BuildContext context) {
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
