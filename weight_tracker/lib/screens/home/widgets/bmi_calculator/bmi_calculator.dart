import 'dart:core';
import 'package:flutter/material.dart';

import 'package:weight_tracker/models/user.dart';
import 'package:weight_tracker/screens/home/widgets/bmi_graph/bmi_graph.dart';
import 'package:weight_tracker/util/bmi_utils.dart';

class BMICalculator extends StatelessWidget {
  final double height;
  final double weight;
  final double graphWidth;

  BMICalculator({
    Key key,
    @required this.height,
    @required this.weight,
    this.graphWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final double bmiResult = calculateBMI(heightInMeter: height, weightInKg: weight);
    final Map<String, dynamic> data = getLabelAndColorByBMIResult(bmiResult, theme);
    final Color resultColor = data['color'];
    final String resultLabel = data['label'];

    return Container(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'BMI Calculator',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: theme.textTheme.bodyText2.color,
                  fontSize: theme.textTheme.headline5.fontSize,
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 24),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      Text(
                        bmiResult.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: theme.textTheme.headline5.color,
                          fontSize: theme.textTheme.headline4.fontSize,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        resultLabel.toUpperCase(),
                        style: TextStyle(
                          color: resultColor,
                          fontSize: theme.textTheme.subtitle2.fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 10),
                    child: BMIGraph(currentValue: bmiResult, graphWidth: graphWidth),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
