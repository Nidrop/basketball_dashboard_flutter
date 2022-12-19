import 'package:basketball_dashboard_flutter/features/basketaball/models/players.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayerNamesEditScreen extends StatefulWidget {
  final int count;

  const PlayerNamesEditScreen({super.key, required this.count});

  @override
  State<PlayerNamesEditScreen> createState() => _PlayerNamesEditScreenState();
}

class _PlayerNamesEditScreenState extends State<PlayerNamesEditScreen> {
  final double rowHeight = 50;

  late PlayersModel players;
  late List<TextEditingController> leftNumbers;
  late List<TextEditingController> rightNumbers;
  late List<TextEditingController> leftNames;
  late List<TextEditingController> rightNames;

  @override
  void initState() {
    super.initState();
    players = Provider.of<PlayersModel>(context, listen: false);
    leftNumbers =
        List.generate(widget.count, (index) => TextEditingController());
    rightNumbers =
        List.generate(widget.count, (index) => TextEditingController());
    leftNames = List.generate(widget.count, (index) => TextEditingController());
    rightNames =
        List.generate(widget.count, (index) => TextEditingController());
    for (var i = 0; i < widget.count; i++) {
      leftNumbers[i].text = players.leftPlayers[i].number;
      leftNames[i].text = players.leftPlayers[i].name;
      rightNumbers[i].text = players.rightPlayers[i].number;
      rightNames[i].text = players.rightPlayers[i].name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Игроки"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
              onPressed: () {
                for (var i = 0; i < widget.count; i++) {
                  /*players.setNumber(1, i, leftNumbers[i].text);
                  players.setNumber(2, i, rightNumbers[i].text);
                  players.setName(1, i, leftNames[i].text);
                  players.setName(1, i, rightNames[i].text);*/
                  players.leftPlayers[i].number = leftNumbers[i].text;
                  players.leftPlayers[i].name = leftNames[i].text;
                  players.rightPlayers[i].number = rightNumbers[i].text;
                  players.rightPlayers[i].name = rightNames[i].text;
                  players.update();
                }
                Navigator.pop(context);
              },
              icon: const Icon(Icons.check)),
        ],
      ),
      body: Row(children: [
        Expanded(
            flex: 4,
            child: ScrollablePlayersColumn(
                rowHeight: rowHeight,
                leftNumbers: leftNumbers,
                rightNumbers: rightNumbers,
                leftNames: leftNames,
                rightNames: rightNames,
                count: widget.count,
                team: 1)),
        Expanded(flex: 1, child: Container()),
        Expanded(
            flex: 4,
            child: ScrollablePlayersColumn(
                rowHeight: rowHeight,
                leftNumbers: leftNumbers,
                rightNumbers: rightNumbers,
                leftNames: leftNames,
                rightNames: rightNames,
                count: widget.count,
                team: 2)),
      ]),
    );
  }
}

class ScrollablePlayersColumn extends StatelessWidget {
  ScrollablePlayersColumn({
    Key? key,
    required this.rowHeight,
    required this.leftNumbers,
    required this.rightNumbers,
    required this.leftNames,
    required this.rightNames,
    required this.count,
    required this.team,
  }) : super(key: key);

  final double rowHeight;
  final List<TextEditingController> leftNumbers;
  final List<TextEditingController> rightNumbers;
  final List<TextEditingController> leftNames;
  final List<TextEditingController> rightNames;
  final int count;
  final int team;

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
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
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: TextField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Номер",
                            ),
                            controller: (team == 1)
                                ? leftNumbers[index]
                                : rightNumbers[index],
                          )),
                      const SizedBox(width: 5),
                      Expanded(
                          flex: 5,
                          child: TextField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "ФИО",
                            ),
                            controller: (team == 1)
                                ? leftNames[index]
                                : rightNames[index],
                          )),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
