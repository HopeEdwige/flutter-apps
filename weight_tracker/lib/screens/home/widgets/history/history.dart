import 'package:flutter/material.dart';
import 'package:weight_tracker/models/weight.dart';

List historyItems = [
  Weight(value: 62.5, timestamp: null, difference: 0.5, differenceType: WeightDifferenceType.INCREASED),
  Weight(value: 62.0, timestamp: null, difference: 0.8, differenceType: WeightDifferenceType.DECREASED),
  Weight(value: 61.2, timestamp: null, difference: 0.3, differenceType: WeightDifferenceType.DECREASED),
];

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'History',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: theme.textTheme.bodyText2.color,
                  fontSize: theme.textTheme.headline5.fontSize,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'See All',
                  style: TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Column(
              children: historyItems.map((item) {
                return Card(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [Text('Today'), Text('${item.difference} kg')],
                      ),
                      Column(
                        children: [Text('${item.value} kg')],
                      )
                    ],
                  ),
                ));
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
