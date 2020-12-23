import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CountdownTitle extends StatelessWidget {
  final String title;
  final String kind;
  final dynamic backgroundColor;

  const CountdownTitle({Key key, this.title, this.kind, this.backgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 50,
              fontStyle: FontStyle.italic,
              backgroundColor: backgroundColor,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          '${toBeginningOfSentenceCase(kind)} in:',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ],
    );
  }
}
