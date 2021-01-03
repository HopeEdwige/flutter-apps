import 'package:flutter/material.dart';
import 'package:weight_tracker/models/weight.dart';

class HistoryList extends StatelessWidget {
  final List<Weight> items;

  const HistoryList({Key key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: items.map((item) {
          return Card(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('Today'),
                    Text('${item.difference} kg'),
                  ],
                ),
                Column(
                  children: [
                    Text('${item.value} kg'),
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
