import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Header extends StatelessWidget {
  final String title;
  final String kind;
  final dynamic backgroundColor;

  const Header({Key key, this.title, this.kind, this.backgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 50,
            fontStyle: FontStyle.italic,
            backgroundColor: backgroundColor,
          ),
          textAlign: TextAlign.center,
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
