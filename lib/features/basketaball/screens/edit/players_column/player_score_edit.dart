import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/players.dart';

class PlayerScoreEdit extends StatelessWidget {
  const PlayerScoreEdit({
    Key? key,
    required this.team,
    required this.index,
  }) : super(key: key);

  final int team;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayersModel>(
      builder: (context, players, child) => Row(
        children: [
          Expanded(
            flex: 2,
            child: FittedBox(
              child: ElevatedButton(
                onPressed: () => players.resetScore(team, index),
                child: const Icon(Icons.refresh),
              ),
            ),
          ),
          const SizedBox(width: 3),
          Expanded(
            flex: 2,
            child: FittedBox(
              child: ElevatedButton(
                onPressed: () => players.subScore(team, index),
                child: const Icon(Icons.remove),
              ),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            flex: 1,
            child: Center(
              child: FittedBox(
                child: Text((team == 1)
                    ? players.leftPlayers[index].score.toString()
                    : players.rightPlayers[index].score.toString()),
              ),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            flex: 2,
            child: FittedBox(
              child: ElevatedButton(
                onPressed: () => players.addScore(team, index),
                child: const Icon(Icons.add),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
