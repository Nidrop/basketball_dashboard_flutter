import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/players.dart';
import '../../../models/teams.dart';

class TeamColumnEdit extends StatelessWidget {
  const TeamColumnEdit({
    Key? key,
    required this.team,
  }) : super(key: key);

  final int team;

  @override
  Widget build(BuildContext context) {
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
}
