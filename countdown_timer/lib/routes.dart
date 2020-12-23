import 'package:countdown_timer/models/countdown_item.dart';
import 'package:flutter/material.dart';
import 'package:countdown_timer/screens/home/index.dart';

List<CountdownItem> countdownItems = [
  new CountdownItem('Corona Virus', 'ending', 1609459201),
  new CountdownItem('New year', 'starting', 1609459201),
  new CountdownItem('New Television', 'arriving', 1609459201),
];

class Routes {
  final routes = <String, WidgetBuilder>{
    '/': (BuildContext context) => new Home(countdownItems: countdownItems),
  };

  Routes() {
    runApp(new MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      title: 'Countdown Timer',
      routes: routes,
    ));
  }
}
