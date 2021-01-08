import 'package:flutter/material.dart';
import 'package:weight_tracker/models/weight.dart';
import 'package:weight_tracker/widgets/history_list/history_list.dart';

class History extends StatelessWidget {
  final List<Weight> items;
  final int itemsToDisplay = 4;

  const History(this.items, {Key key}) : super(key: key);

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
                onPressed: () {
                  Navigator.pushNamed(context, '/history');
                },
                child: Text(
                  'See All',
                  style: TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
          HistoryList(
            items: items.take(itemsToDisplay).toList(growable: false),
          ),
        ],
      ),
    );
  }
}
