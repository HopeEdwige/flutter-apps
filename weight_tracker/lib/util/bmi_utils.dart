import 'dart:math';

import 'package:flutter/material.dart';

double calculateBMI({double weightInKg, double heightInMeter}) {
  return round(weightInKg / pow(heightInMeter, 2));
}

double convertHeightFromFtToMeters(height) {
  return height * 0.3048;
}

double convertHeightFromMetersToFt(height) {
  return height / 0.3048;
}

double convertKgToLbs(weight) {
  return weight / 703;
}

double convertLbsToKg(weight) {
  return weight * 703;
}

double roundDown(double value, int precision) {
  final isNegative = value.isNegative;
  final mod = pow(10.0, precision);
  final roundDown = (((value.abs() * mod).floor()) / mod);
  return isNegative ? -roundDown : roundDown;
}

/// Returns rounded number by half
/// number=20.6903 ==> 20.5
/// number=20.2210 ==> 20.0
double round(double number) {
  var value = num.parse((number * 2).toStringAsFixed(0)) / 2;
  return value;
}

Map<String, dynamic> getLabelAndColorByBMIResult(double result, ThemeData theme) {
  Map<String, dynamic> data = {};

  if (result < 18.5) {
    data['label'] = "You're underweight";
    data['color'] = Colors.blue;
  } else if (result >= 18.5 && result <= 24.9) {
    data['label'] = "You're healthy";
    data['color'] = theme.colorScheme.primary ?? Colors.greenAccent;
  } else if (result >= 25.0 && result <= 29.9) {
    data['label'] = "You're overweight";
    data['color'] = Colors.yellow;
  } else {
    data['label'] = "You're obese";
    data['color'] = Colors.red;
  }
  return data;
}
