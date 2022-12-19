import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/players.dart';

class PlayerFallsEdit extends StatelessWidget {
  const PlayerFallsEdit({
    Key? key,
    required this.team,
    required this.index,
  }) : super(key: key);

  final int team;
  final int index;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Consumer<PlayersModel>(
        builder: (context, players, child) => ElevatedButton(
          onPressed: () => players.addFall(team, index),
          onLongPress: () => players.subFall(team, index),
          child: Text((team == 1)
              ? players.leftPlayers[index].falls.toString()
              : players.rightPlayers[index].falls.toString()),
        ),
      ),
    );
  }
}
