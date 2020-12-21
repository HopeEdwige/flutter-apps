import 'package:flutter/material.dart';
import 'package:countdown_timer/screens/countdown.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Countdown',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CountDown(),
      debugShowCheckedModeBanner: false,
    );
  }
}
