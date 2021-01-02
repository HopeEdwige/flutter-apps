import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

const sheetPadding = 50;

class Progress extends StatelessWidget {
  final double target;
  final double current;
  final double initial;

  Progress({Key key, this.target, this.current, this.initial}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    double percent = calculatePercentage(initial, current, target);

    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildWeightMeasure(theme, initial.toString()),
              _buildWeightMeasure(
                theme,
                current.toString(),
                color: theme.textTheme.headline5.color,
                fontSize: theme.textTheme.headline2.fontSize,
                measureFontSize: 20,
              ),
              _buildWeightMeasure(theme, target.toString()),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 3,
            child: LinearPercentIndicator(
              lineHeight: 3,
              percent: percent,
              animation: true,
              animateFromLastPercent: true,
              animationDuration: 300,
              width: size.width - sheetPadding,
              backgroundColor: theme.cardColor,
              progressColor: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeightMeasure(ThemeData theme, String value, {double fontSize, Color color, double measureFontSize}) {
    color = color ?? theme.textTheme.bodyText2.color;
    fontSize = fontSize ?? theme.textTheme.headline5.fontSize;
    measureFontSize = measureFontSize ?? theme.textTheme.subtitle1.fontSize;

    return Text.rich(TextSpan(
      text: value,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      ),
      children: [TextSpan(text: 'kg', style: TextStyle(fontSize: measureFontSize))],
    ));
  }

  double calculatePercentage(double initial, double current, double target) {
    double totalTime = target - initial;
    double progress = current - initial;
    double percentage = ((progress / totalTime) * 100).clamp(0.0, 100.0);
    return percentage / 100;
  }
}
