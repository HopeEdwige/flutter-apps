import 'package:flutter/material.dart';

import 'package:weight_tracker/screens/home/index.dart';
import 'package:weight_tracker/screens/history/index.dart';
import 'package:weight_tracker/screens/sign_up/index.dart';
import 'package:weight_tracker/screens/new_weight/index.dart';

class Routes {
  static final String defaultRoute = '/sign-up';

  static final list = <String, WidgetBuilder>{
    '/': (BuildContext context) => new HomeScreen(),
    '/new': (BuildContext context) {
      final arguments = ModalRoute.of(context).settings.arguments as Map;
      return new NewWeightScreen(selectedWeight: arguments['selectedWeight']);
    },
    '/history': (BuildContext context) => new HistoryScreen(),
    '/sign-up': (BuildContext context) => new SignUpScreen(),
  };
}
