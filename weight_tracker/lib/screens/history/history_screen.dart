import 'package:flutter/material.dart';
import 'package:weight_tracker/models/weight.dart';
import 'package:weight_tracker/widgets/history_list/history_list.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          backgroundColor: theme.scaffoldBackgroundColor,
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  size: 28,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            )
          ],
          title: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'History',
              style: TextStyle(fontSize: theme.textTheme.headline4.fontSize),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: HistoryList(items: [
            Weight(value: 62.5, timestamp: 1588728871, difference: 0.5, differenceType: WeightDifferenceType.INCREASED),
            Weight(value: 62.0, timestamp: 1576517453, difference: 0.8, differenceType: WeightDifferenceType.DECREASED),
            Weight(value: 61.2, timestamp: 1585615271, difference: 0.3, differenceType: WeightDifferenceType.DECREASED),
            Weight(value: 59.2, timestamp: 1587580164, difference: 1.0, differenceType: WeightDifferenceType.SAME),
            Weight(value: 59.2, timestamp: 1589019189, difference: 1.0, differenceType: WeightDifferenceType.INCREASED),
            Weight(value: 62.5, timestamp: 1600739600, difference: 0.5, differenceType: WeightDifferenceType.INCREASED),
            Weight(value: 62.0, timestamp: 1597522588, difference: 0.8, differenceType: WeightDifferenceType.DECREASED),
            Weight(value: 61.2, timestamp: 1589364728, difference: 0.3, differenceType: WeightDifferenceType.DECREASED),
            Weight(value: 59.2, timestamp: 1601720155, difference: 1.0, differenceType: WeightDifferenceType.SAME),
            Weight(value: 59.2, timestamp: 1595712447, difference: 1.0, differenceType: WeightDifferenceType.INCREASED),
          ]),
        ),
      ),
    );
  }
}
