import 'package:flutter/material.dart';

import 'package:weight_tracker/util/theme_utils.dart';
import 'package:weight_tracker/screens/home_screen/index.dart';

class Routes {
  static getApp() {
    return new MaterialApp(
      title: 'Weight Tracker',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) {
              // todo check if user data is present in db, if not, display intro screen.
              return HomeScreen();
            });
        }
        return null;
      },
      theme: ThemeData(
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,

        //theme
        primarySwatch: createMaterialColor(Color.fromRGBO(26, 255, 213, 1)),
        cardColor: Color.fromRGBO(32, 33, 55, 1),
        backgroundColor: Color.fromRGBO(22, 24, 36, 1),
        scaffoldBackgroundColor: Color.fromRGBO(22, 24, 36, 1),
      ),
    );
  }

  Routes() {
    runApp(getApp());
  }
}
