import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quiz_app/models/topic.dart';
import 'package:auto_size_text/auto_size_text.dart';

class TopicCard extends StatelessWidget {
  final Topic topic;

  TopicCard({Key key, this.topic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MaterialButton(
      elevation: 1.0,
      highlightElevation: 1.0,
      onPressed: () => {},
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      color: theme.cardColor,
      textColor: theme.textTheme.headline2.color,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            topic.icon,
            size: 30,
            color: topic.iconColor,
          ),
          SizedBox(height: 20),
          AutoSizeText(
            topic.name,
            minFontSize: 20,
            textAlign: TextAlign.center,
            maxLines: 2,
            wrapWords: true,
          ),
        ],
      ),
    );
  }
}
