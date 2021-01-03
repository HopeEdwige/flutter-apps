import 'package:flutter/material.dart';

class TextWithMeasure extends StatelessWidget {
  final String text;
  final String measure;
  final Color color;
  final double fontSize;
  final double measureFontSize;

  TextWithMeasure({
    Key key,
    @required this.text,
    this.measure = 'kg',
    this.color,
    this.fontSize,
    this.measureFontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color _color = color ?? theme.textTheme.bodyText2.color;
    final double _fontSize = fontSize ?? theme.textTheme.headline5.fontSize;
    final double _measureFontSize = measureFontSize ?? theme.textTheme.subtitle1.fontSize;

    return Text.rich(TextSpan(
      text: text,
      style: TextStyle(
        color: _color,
        fontSize: _fontSize,
        fontWeight: FontWeight.bold,
      ),
      children: [
        TextSpan(
          text: ' $measure',
          style: TextStyle(fontSize: _measureFontSize),
        )
      ],
    ));
  }
}
