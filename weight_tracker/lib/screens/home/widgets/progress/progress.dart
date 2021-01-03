import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:weight_tracker/widgets/text_with_measure/index.dart';

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
              TextWithMeasure(text: initial.toString()),
              TextWithMeasure(
                measureFontSize: 20,
                text: current.toString(),
                color: theme.textTheme.headline5.color,
                fontSize: theme.textTheme.headline2.fontSize,
              ),
              TextWithMeasure(text: target.toString()),
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

  double calculatePercentage(double initial, double current, double target) {
    double totalTime = target - initial;
    double progress = current - initial;
    double percentage = ((progress / totalTime) * 100).clamp(0.0, 100.0);
    return percentage / 100;
  }
}
