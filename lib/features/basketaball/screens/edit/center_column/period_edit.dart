import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/period.dart';

class PeriodEdit extends StatelessWidget {
  const PeriodEdit({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Consumer<PeriodModel>(
        builder: (context, period, child) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Период:"),
            ElevatedButton(
              onPressed: () {
                period.add();
              },
              onLongPress: () {
                period.sub();
              },
              child: Text(period.period.toString()),
            ),
          ],
        ),
      ),
    );
  }
}
