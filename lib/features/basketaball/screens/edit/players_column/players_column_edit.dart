import 'package:basketball_dashboard_flutter/features/basketaball/models/players.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../player_names_edit_screen.dart';

class PlayersColumnEdit extends StatelessWidget {
  final int team;
  final int count;
  final double rowHeight;
  final scrollController = ScrollController();
  PlayersColumnEdit({
    Key? key,
    required this.team,
    required this.count,
    required this.rowHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        playersColumnTitles(),
        const Divider(
          height: 4,
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraits) => ListView(
              controller: scrollController,
              children: [
                Container(
                  constraints: BoxConstraints(minHeight: constraits.maxHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List<Widget>.generate(count, (int index) {
                      return Container(
                        padding: const EdgeInsets.all(5),
                        height: rowHeight,
                        child: playerRow(context, index),
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

  Widget playersColumnTitles() {
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

  Widget playerRow(BuildContext context, int index) {
    return Row(
      children: [
        Expanded(flex: 1, child: playerNameButtonEdit(context, index)),
        const SizedBox(width: 5),
        Expanded(flex: 1, child: playerFallsEdit(index)),
        const VerticalDivider(),
        Expanded(flex: 3, child: playerScoreEdit(index)),
      ],
    );
  }

  Widget playerNameButtonEdit(BuildContext context, int index) {
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

  Widget playerFallsEdit(int index) {
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

  Widget playerScoreEdit(int index) {
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
