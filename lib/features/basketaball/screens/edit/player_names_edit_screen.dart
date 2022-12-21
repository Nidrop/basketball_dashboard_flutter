import 'package:basketball_dashboard_flutter/features/basketaball/models/players.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';

class PlayerNamesEditScreen extends StatefulWidget {
  final int count;

  const PlayerNamesEditScreen({super.key, required this.count});

  @override
  State<PlayerNamesEditScreen> createState() => PlayerNamesEditScreenState();
}

class PlayerNamesEditScreenState extends State<PlayerNamesEditScreen> {
  final double rowHeight = 50;

  late PlayersModel players;
  late List<TextEditingController> leftNumbers;
  late List<TextEditingController> rightNumbers;
  late List<TextEditingController> leftNames;
  late List<TextEditingController> rightNames;

  late TextEditingController focusedController;

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

    focusedController = leftNumbers[0];
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
      body: Column(children: [
        Expanded(
          child: Row(children: [
            Expanded(
                flex: 4,
                child: ScrollablePlayersColumn(
                    rowHeight: rowHeight,
                    team: 1,
                    count: widget.count,
                    owner: this)),
            Expanded(flex: 1, child: Container()),
            Expanded(
                flex: 4,
                child: ScrollablePlayersColumn(
                  rowHeight: rowHeight,
                  team: 2,
                  count: widget.count,
                  owner: this,
                )),
          ]),
        ),
        Expanded(
          child: VirtualKeyboard(
            textController: focusedController,
            defaultLayouts: const [
              VirtualKeyboardDefaultLayouts.Russian,
              VirtualKeyboardDefaultLayouts.English,
            ],
            type: VirtualKeyboardType.Alphanumeric,
            onKeyPress: (key) {
              if (key.keyType == VirtualKeyboardKeyType.String) {
                //leftNames[1].text += key.text;

              }
            },
          ),
        ),
      ]),
    );
  }
}

class ScrollablePlayersColumn extends StatelessWidget {
  ScrollablePlayersColumn(
      {Key? key,
      required this.rowHeight,
      required this.team,
      required this.count,
      required this.owner})
      : super(key: key);

  final double rowHeight;
  final int team;
  final int count;
  PlayerNamesEditScreenState owner;

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
                                ? owner.leftNumbers[index]
                                : owner.rightNumbers[index],
                            onTap: () {
                              owner.focusedController = (team == 1)
                                  ? owner.leftNumbers[index]
                                  : owner.rightNumbers[index];
                              owner.setState(() {});
                            },
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
                                ? owner.leftNames[index]
                                : owner.rightNames[index],
                            onTap: () {
                              owner.focusedController = (team == 1)
                                  ? owner.leftNames[index]
                                  : owner.rightNames[index];
                              owner.setState(() {});
                            },
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
