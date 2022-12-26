import 'package:basketball_dashboard_flutter/features/basketaball/screens/view/center_column/center_column_view.dart';
import 'package:flutter/material.dart';
import 'players_column/players_column_view.dart';

class BasketballViewScreen extends StatelessWidget {
  const BasketballViewScreen({Key? key, required this.count}) : super(key: key);

  final int count;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Basketball Dashboard View",
      //theme: ThemeData.dark(),
      home: BasketballViewPage(count: count),
    );
  }
}

class BasketballViewPage extends StatelessWidget {
  const BasketballViewPage({
    Key? key,
    required this.count,
  }) : super(key: key);

  final int count;

  @override
  Widget build(BuildContext context) {
    //TODO: delete theme
    return Theme(
      data: ThemeData(brightness: Brightness.dark, canvasColor: Colors.black),
      child: Scaffold(
        //TODO: delete appbar
        appBar: AppBar(
          title: const Text("Temp"),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: Row(
          children: [
            Expanded(
              flex: 3,
              child: PlayersColumnView(
                team: 1,
                count: 12,
                rowHeight: 50,
              ),
            ),
            const VerticalDivider(),
            Expanded(
              flex: 4,
              child: CenterColumnView(),
            ),
            const VerticalDivider(),
            Expanded(
              flex: 3,
              child: PlayersColumnView(
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
