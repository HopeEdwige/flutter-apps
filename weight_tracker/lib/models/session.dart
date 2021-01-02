import 'package:flutter/material.dart';
import 'package:weight_tracker/models/user.dart';

class Session extends ChangeNotifier {
  User _activeUser;

  User get user => _activeUser;

  void set(User user) {
    _activeUser = user;
    notifyListeners();
  }

  void flush() {
    _activeUser = null;
    notifyListeners();
  }
}
