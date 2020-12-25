import 'dart:ui';
import 'package:flutter/material.dart';

class TopicCard extends StatelessWidget {
  const TopicCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: theme.canvasColor,
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4.0,
            offset: const Offset(0.0, 4.0),
          ),
        ],
      ),
      child: Center(
        child: Container(
          child: Text(
            'Educational',
            style: theme.textTheme.headline5,
          ),
        ),
      ),
    );
  }
}
