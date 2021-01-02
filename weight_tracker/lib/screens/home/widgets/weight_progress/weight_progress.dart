import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

const sheetPadding = 50;

class WeightProgress extends StatelessWidget {
  final double target;
  final double current;
  final double initial;

  WeightProgress({Key key, this.target, this.current, this.initial}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    double percent = calculatePercentage(initial, current, target);

    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text.rich(TextSpan(
                  text: initial.toString(),
                  style: TextStyle(
                    color: theme.textTheme.bodyText2.color,
                    fontSize: theme.textTheme.headline5.fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [TextSpan(text: 'kg', style: TextStyle(fontSize: theme.textTheme.subtitle1.fontSize))],
                )),
                Text.rich(TextSpan(
                  text: current.toString(),
                  style: TextStyle(
                    color: theme.textTheme.headline5.color,
                    fontSize: theme.textTheme.headline2.fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [TextSpan(text: 'kg', style: TextStyle(fontSize: 20))],
                )),
                Text.rich(TextSpan(
                  text: target.toString(),
                  style: TextStyle(
                    color: theme.textTheme.bodyText2.color,
                    fontSize: theme.textTheme.headline5.fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [TextSpan(text: 'kg', style: TextStyle(fontSize: theme.textTheme.subtitle1.fontSize))],
                )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            LinearPercentIndicator(
              lineHeight: 3,
              percent: percent,
              animation: true,
              animateFromLastPercent: true,
              animationDuration: 300,
              width: size.width - sheetPadding,
              backgroundColor: theme.cardColor,
              progressColor: theme.colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }

  double calculatePercentage(double initial, double current, double target) {
    //todo
    return .3;
  }
}
