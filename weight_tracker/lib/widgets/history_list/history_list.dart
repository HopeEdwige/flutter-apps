import 'package:flutter/material.dart';
import 'package:weight_tracker/calender_date.dart';
import 'package:weight_tracker/models/weight.dart';
import 'package:weight_tracker/widgets/text_with_measure/index.dart';

class HistoryList extends StatelessWidget {
  final List<Weight> items;

  const HistoryList({Key key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: items.map((item) => _buildCard(context, item)).toList(),
      ),
    );
  }

  Widget _buildCard(BuildContext context, Weight item) {
    final ThemeData theme = Theme.of(context);
    final formattedDate = CalendarDate.fromTimeStamp(item.timestamp).toHuman;

    IconData icon;
    Color highLightColor;

    switch (item.diff.type) {
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
                  formattedDate,
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
                      color: highLightColor,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    TextWithMeasure(
                      fontSize: 20,
                      color: highLightColor,
                      text: item.diff.value.toString(),
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
      ),
    );
  }
}
