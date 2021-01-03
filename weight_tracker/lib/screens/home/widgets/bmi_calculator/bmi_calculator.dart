import 'dart:core';
import 'package:flutter/material.dart';

import 'package:weight_tracker/models/user.dart';
import 'package:weight_tracker/screens/home/widgets/bmi_graph/bmi_graph.dart';

class BMICalculator extends StatelessWidget {
  final double currentWeight;
  final User user;

  BMICalculator({Key key, @required this.user, @required this.currentWeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

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
                        '23.14',
                        style: TextStyle(
                          color: theme.textTheme.headline5.color,
                          fontSize: theme.textTheme.headline4.fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'YOU\'RE HEALTHY',
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontSize: theme.textTheme.subtitle2.fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    width: double.infinity,
                    child: BMIGraph(currentValue: 23.5),
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
