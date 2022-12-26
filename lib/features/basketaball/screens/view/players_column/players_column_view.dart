import 'package:flutter/material.dart';

class PlayersColumnView extends StatelessWidget {
  final int team;
  final int count;
  final double rowHeight;
  //final scrollController = ScrollController();
  const PlayersColumnView({
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
          child: StatsColumns(count: count, team: team),
        ),
      ],
    );
  }
}

class StatsColumns extends StatelessWidget {
  const StatsColumns({
    Key? key,
    required this.count,
    required this.team,
  }) : super(key: key);

  final int count;
  final int team;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 2),
        Expanded(flex: 1, child: PlayerNumbersColumn(team: team, count: count)),
        const VerticalDivider(),
        Expanded(flex: 5, child: PlayerNamesColumn(team: team, count: count)),
        const VerticalDivider(),
        Expanded(flex: 1, child: PlayerFallsColumn(team: team, count: count)),
        const VerticalDivider(),
        Expanded(flex: 1, child: PlayerScoresColumn(team: team, count: count)),
      ],
    );
  }
}

class PlayerNumbersColumn extends StatelessWidget {
  const PlayerNumbersColumn(
      {super.key, required this.count, required this.team});

  final int count;
  final int team;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(count, (index) {
        return Expanded(child: Text("0"));
      }),
    );
  }
}

class PlayerFallsColumn extends StatelessWidget {
  const PlayerFallsColumn({super.key, required this.count, required this.team});

  final int count;
  final int team;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(count, (index) {
        return Expanded(child: Text("0"));
      }),
    );
  }
}

class PlayerScoresColumn extends StatelessWidget {
  const PlayerScoresColumn(
      {super.key, required this.count, required this.team});

  final int count;
  final int team;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(count, (index) {
        return Expanded(child: Text("0"));
      }),
    );
  }
}

class PlayerNamesColumn extends StatelessWidget {
  const PlayerNamesColumn({super.key, required this.count, required this.team});

  final int count;
  final int team;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(count, (index) {
        return Expanded(child: Text("Text"));
      }),
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
          SizedBox(width: 2),
          Expanded(flex: 1, child: Text("№")),
          VerticalDivider(),
          Expanded(flex: 5, child: Text("ФИО")),
          VerticalDivider(),
          Expanded(flex: 1, child: Text("Фолы")),
          VerticalDivider(),
          Expanded(flex: 1, child: Text("Счет")),
        ],
      ),
    );
  }
}
