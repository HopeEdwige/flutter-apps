import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weight_tracker/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  Routes();
}
