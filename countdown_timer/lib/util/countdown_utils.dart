import 'package:flutter/material.dart';
import 'package:countdown_timer/models/countdown_shade.dart';

List<int> last3ShadesIndexes = [];

List<CountdownShade> countdownShades = [
  new CountdownShade(
    background: Colors.brown,
    labelBackground: Colors.brown[700],
    durationBackground: Colors.brown[700],
  ),
  new CountdownShade(
    background: Colors.deepPurple,
    labelBackground: Colors.deepPurple[800],
    durationBackground: Colors.deepPurple[800],
  ),
  new CountdownShade(
    background: Colors.teal,
    labelBackground: Colors.teal[800],
    durationBackground: Colors.teal[800],
  ),
  new CountdownShade(
    background: Colors.amber,
    labelBackground: Colors.amber[800],
    durationBackground: Colors.amber[800],
  ),
  new CountdownShade(
    background: Colors.blue,
    labelBackground: Colors.blue[800],
    durationBackground: Colors.blue[800],
  ),
  new CountdownShade(
    background: Colors.pink,
    labelBackground: Colors.pink[800],
    durationBackground: Colors.pink[800],
  ),
];

CountdownShade generateShade() {
  CountdownShade color = (countdownShades.toList()..shuffle()).first;
  int colorIndex = countdownShades.indexOf(color);

  if (last3ShadesIndexes.indexOf(colorIndex) != -1) {
    return generateShade();
  }

  if (last3ShadesIndexes.length >= 3) {
    last3ShadesIndexes.removeAt(0);
  }

  last3ShadesIndexes.add(colorIndex);

  return color;
}
