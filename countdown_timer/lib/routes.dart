import 'package:flutter/material.dart';
import 'package:countdown_timer/screens/home/index.dart';
import 'package:countdown_timer/models/countdown_item.dart';

var nextYear = DateTime.now().year + 1;
List<CountdownItem> countdownItems = [
  new CountdownItem(
    kind: 'ending',
    label: 'Covid-19 Pandemic',
    endDate: DateTime(nextYear, DateTime.december).millisecondsSinceEpoch,
  ),
  new CountdownItem(
    kind: 'beginning',
    label: 'New year',
    endDate: DateTime(nextYear, DateTime.january).millisecondsSinceEpoch,
  ),
  new CountdownItem(
    kind: 'coming',
    label: 'Next Birthday',
    endDate: DateTime(nextYear, DateTime.july, 16).millisecondsSinceEpoch,
  ),
  new CountdownItem(
    kind: 'arriving',
    label: 'New Package',
    endDate: DateTime(nextYear, DateTime.february, 27).millisecondsSinceEpoch,
  ),
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
      debugShowCheckedModeBanner: false,
    ));
  }
}
