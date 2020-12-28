import 'package:flutter/material.dart';

class TabItem {
  final String title;
  final Widget Function() viewBuilder;

  TabItem({this.title, this.viewBuilder});
}
