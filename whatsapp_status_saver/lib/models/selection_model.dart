import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:whatsapp_status_saver/models/status_item.dart';

class SelectionModel extends ChangeNotifier {
  final List<StatusItem> _items = [];

  UnmodifiableListView<StatusItem> get items => UnmodifiableListView(_items);
  UnmodifiableListView<StatusItem> get videos => UnmodifiableListView(_items.where((item) => item.type == StatusType.video));
  UnmodifiableListView<StatusItem> get images => UnmodifiableListView(_items.where((item) => item.type == StatusType.image));

  get isEmpty => items.length == 0;

  get isNotEmpty => items.length > 0;

  bool hasItem(StatusItem item) {
    return _items.indexWhere((e) => e.path == item.path) != -1;
  }

  void add(StatusItem item) {
    _items.add(item);
    notifyListeners();
  }

  void remove(StatusItem item) {
    _items.removeWhere((e) => e.path == item.path);
    notifyListeners();
  }

  void toggle(StatusItem item) {
    if (hasItem(item)) {
      remove(item);
    } else {
      add(item);
    }
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }
}
