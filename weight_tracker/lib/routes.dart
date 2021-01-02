import 'package:flutter/material.dart';
import 'package:weight_tracker/screens/signup_screen/index.dart';

import 'package:weight_tracker/screens/home_screen/index.dart';

class Routes {
  static final list = <String, WidgetBuilder>{
    '/home': (BuildContext context) => new HomeScreen(),
    '/sign-up': (BuildContext context) => new SignUpScreen(),
  };
}
