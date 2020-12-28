import 'package:flutter/material.dart';

import 'package:whatsapp_status_saver/screens/home_screen/index.dart';

class Routes {
  final routes = <String, WidgetBuilder>{
    '/': (BuildContext context) => new HomeScreen(),
  };

  Routes() {
    runApp(new MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: routes,
      title: 'WhatsApp Status Saver',
      debugShowCheckedModeBanner: false,
    ));
  }
}
