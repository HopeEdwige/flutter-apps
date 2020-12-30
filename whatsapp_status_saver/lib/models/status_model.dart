import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:whatsapp_status_saver/models/status_item.dart';
import 'package:whatsapp_status_saver/services/status_service.dart';

class StatusModel extends ChangeNotifier {
  bool isFetchingVideoThumbnails = false;
  final List<StatusItem> _items = [];

  UnmodifiableListView<StatusItem> get items => UnmodifiableListView(_items);

  UnmodifiableListView<StatusItem> get videos => UnmodifiableListView(_items.where((item) => item.type == StatusType.video));

  UnmodifiableListView<StatusItem> get images => UnmodifiableListView(_items.where((item) => item.type == StatusType.image));

  get isEmpty => _items.length == 0;

  get isNotEmpty => _items.length > 0;

  get isGeneratingVideoThumbnails {
    var filtered = _items.where((item) => item.isLoading);
    return filtered != null;
  }

  bool hasItem(StatusItem item) {
    return _items.contains(item);
  }

  void add(StatusItem item) {
    _items.add(item);
    notifyListeners();
  }

  void addAll(Iterable<StatusItem> items) {
    _items.addAll(items);
    notifyListeners();
  }

  void remove(StatusItem item) {
    _items.remove(item);
    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }

  fetch() {
    _items.clear();
    addAll(getStatusList());
  }
}
