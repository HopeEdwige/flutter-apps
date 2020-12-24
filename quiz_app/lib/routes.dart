import 'package:flutter/material.dart';
import 'package:quiz_app/screens/home_screen/index.dart';

class Routes {
  final routes = <String, WidgetBuilder>{
    '/': (BuildContext context) => new Home(title: 'Home'),
  };

  Routes() {
    runApp(new MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      title: 'Quiz App',
      routes: routes,
      debugShowCheckedModeBanner: false,
    ));
  }
}
