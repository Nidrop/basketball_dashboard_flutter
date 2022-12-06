import 'package:basketball_dashboard_flutter/features/basketaball/models/period.dart';
import 'package:basketball_dashboard_flutter/features/basketaball/models/teams.dart';
import 'package:basketball_dashboard_flutter/features/basketaball/models/timer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/players.dart';
import 'center_column/center_column_edit.dart';
import 'players_column/players_column_edit.dart';

class BasketballEditScreen extends StatelessWidget {
  const BasketballEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Basketball Dashboard Edit",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Баскетбол"),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.connected_tv)),
            IconButton(
              // ignore: todo
              //TODO create new window
              onPressed: () {},
              icon: const Icon(Icons.add_box),
            ),
          ],
        ),
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => PlayersModel()),
            ChangeNotifierProvider(create: (context) => TeamsModel()),
            ChangeNotifierProvider(create: (context) => PeriodModel()),
          ],
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: PlayersColumnEdit(
                  team: 1,
                  count: 12,
                  rowHeight: 50,
                ),
              ),
              const VerticalDivider(),
              const Expanded(
                flex: 4,
                child: CenterColumnEdit(),
              ),
              const VerticalDivider(),
              Expanded(
                flex: 3,
                child: PlayersColumnEdit(
                  team: 2,
                  count: 12,
                  rowHeight: 50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
