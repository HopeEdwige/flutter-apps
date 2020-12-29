import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:whatsapp_status_saver/models/selected_item.dart';

class SelectionModel extends ChangeNotifier {
  final List<SelectedItem> _items = [];

  UnmodifiableListView<SelectedItem> get items => UnmodifiableListView(_items);

  void add(SelectedItem item) {
    _items.add(item);
    notifyListeners();
  }

  void remove(String path) {
    _items.removeWhere((item) => item.path == path);
    notifyListeners();
  }

  bool hasItem(String path) {
    return _items.indexWhere((e) => e.path == path) != -1;
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }
}
