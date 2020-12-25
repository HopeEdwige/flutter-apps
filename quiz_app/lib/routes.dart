import 'package:flutter/material.dart';

import 'package:quiz_app/screens/home_screen/index.dart';
import 'package:quiz_app/screens/topics_screen/index.dart';

class Routes {
  final routes = <String, WidgetBuilder>{
    '/': (BuildContext context) => new HomeScreen(),
    '/topics': (BuildContext context) => new TopicsScreen(),
    // '/quiz': () => new QuizScreen(questions: null),
  };

  Routes() {
    runApp(new MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      title: 'Quiz App',
      routes: routes,
      debugShowCheckedModeBanner: false,
    ));
  }
}
