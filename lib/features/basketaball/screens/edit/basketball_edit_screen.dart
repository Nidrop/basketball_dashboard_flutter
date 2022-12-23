import 'package:basketball_dashboard_flutter/features/basketaball/models/period.dart';
import 'package:basketball_dashboard_flutter/features/basketaball/models/teams.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../models/players.dart';
import 'center_column/center_column_edit.dart';
import 'players_column/players_column_edit.dart';

class BasketballEditScreen extends StatelessWidget {
  const BasketballEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Basketball Dashboard Edit",
      home: BasketballEditPage(),
    );
  }
}

class BasketballEditPage extends StatelessWidget {
  const BasketballEditPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Баскетбол"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.connected_tv)),
          IconButton(
            //TODO create new window
            onPressed: () {},
            icon: const Icon(Icons.add_box),
          ),
        ],
      ),
      drawer: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: [
        const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Меню',
              style: TextStyle(color: Colors.white, fontSize: 20),
            )),
        ListTile(
          title: const Text('Выключить'),
          onTap: () {
            showDialog(
                context: context,
                builder: ((context) {
                  return AlertDialog(
                    title: const Text("Выключить"),
                    titleTextStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                    actionsOverflowButtonSpacing: 20,
                    actionsAlignment: MainAxisAlignment.spaceBetween,
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Отмена")),
                      //TODO: скрипт выключения
                      ElevatedButton(onPressed: () {}, child: const Text("Да")),
                    ],
                    content: const Text(
                        "Вы уверены, что хотите выключить устройство?"),
                  );
                }));
          },
          onLongPress: () {
            showDialog(
                context: context,
                builder: ((context) {
                  return AlertDialog(
                    title: const Text("Выход"),
                    titleTextStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                    actionsOverflowButtonSpacing: 20,
                    actionsAlignment: MainAxisAlignment.spaceBetween,
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Отмена")),
                      ElevatedButton(
                          onPressed: () {
                            SystemNavigator.pop();
                          },
                          child: const Text("Да")),
                    ],
                    content: const Text(
                      "Вы уверены, что хотите закрыть приложение и выйти в систему?",
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                }));
          },
        ),
      ])),
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
    );
  }
}
