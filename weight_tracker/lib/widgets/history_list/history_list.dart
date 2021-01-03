import 'package:flutter/material.dart';
import 'package:weight_tracker/models/weight.dart';
import 'package:weight_tracker/widgets/text_with_measure/index.dart';

class HistoryList extends StatelessWidget {
  final List<Weight> items;

  const HistoryList({Key key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      child: Column(
        children: items.map((item) {
          IconData icon;
          Color highLightColor;

          switch (item.differenceType) {
            case WeightDifferenceType.INCREASED:
              icon = Icons.arrow_upward;
              highLightColor = Colors.red;
              break;
            case WeightDifferenceType.DECREASED:
              icon = Icons.arrow_downward;
              highLightColor = theme.colorScheme.primary;
              break;
            case WeightDifferenceType.SAME:
              icon = Icons.circle;
              highLightColor = Colors.yellow;
              break;
          }

          return Card(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Today',
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          icon,
                          size: 18,
                          color: highLightColor,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${item.difference} kg',
                          style: TextStyle(color: highLightColor, fontSize: 20),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    TextWithMeasure(
                      fontSize: 30,
                      text: item.value.toString(),
                      color: theme.textTheme.headline5.color,
                    )
                  ],
                )
              ],
            ),
          ));
        }).toList(),
      ),
    );
  }
}
