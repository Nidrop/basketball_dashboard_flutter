import 'package:flutter/material.dart';

import 'player_falls_edit.dart';
import 'player_name_button_edit.dart';
import 'player_score_edit.dart';

class PlayersColumnEdit extends StatelessWidget {
  final int team;
  final int count;
  final double rowHeight;
  //final scrollController = ScrollController();
  const PlayersColumnEdit({
    Key? key,
    required this.team,
    required this.count,
    required this.rowHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const PlayersColumnTitles(),
        const Divider(
          height: 4,
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraits) => ListView(
              //controller: scrollController,
              children: [
                Container(
                  constraints: BoxConstraints(minHeight: constraits.maxHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List<Widget>.generate(count, (int index) {
                      return Container(
                        padding: const EdgeInsets.all(5),
                        height: rowHeight,
                        child:
                            PlayerRow(count: count, team: team, index: index),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class PlayerRow extends StatelessWidget {
  const PlayerRow({
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
    return Row(
      children: [
        Expanded(
            flex: 1,
            child:
                PlayerNameButtonEdit(count: count, team: team, index: index)),
        const SizedBox(width: 5),
        Expanded(flex: 1, child: PlayerFallsEdit(team: team, index: index)),
        const VerticalDivider(),
        Expanded(flex: 3, child: PlayerScoreEdit(team: team, index: index)),
      ],
    );
  }
}

class PlayersColumnTitles extends StatelessWidget {
  const PlayersColumnTitles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: Row(
        children: const [
          SizedBox(width: 5),
          Expanded(flex: 1, child: Text("№")),
          SizedBox(width: 5),
          Expanded(flex: 1, child: Text("Фолы")),
          VerticalDivider(),
          Expanded(flex: 3, child: Text("Счет")),
          SizedBox(width: 5),
        ],
      ),
    );
  }
}
