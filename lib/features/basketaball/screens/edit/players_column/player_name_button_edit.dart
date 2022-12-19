import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/players.dart';
import '../player_names_edit_screen.dart';

class PlayerNameButtonEdit extends StatelessWidget {
  const PlayerNameButtonEdit({
    Key? key,
    required this.count,
    required this.team,
    required this.index,
  }) : super(key: key);

  final int count;
  final int team;
  final int index;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueGrey,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ChangeNotifierProvider.value(
                      value: Provider.of<PlayersModel>(context),
                      child: PlayerNamesEditScreen(
                        count: count,
                      ),
                    )),
          );
        },
        child: Consumer<PlayersModel>(
            builder: (context, players, child) => Text((team == 1)
                ? players.leftPlayers[index].number
                : players.rightPlayers[index].number)),
      ),
    );
  }
}
