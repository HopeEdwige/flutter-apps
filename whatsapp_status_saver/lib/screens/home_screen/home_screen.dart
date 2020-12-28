import 'package:flutter/material.dart';
import 'package:whatsapp_status_saver/models/tab_item.dart';

final List<TabItem> navItems = [
  TabItem(
    title: 'Images',
    viewBuilder: () => Text('Images'),
  ),
  TabItem(
    title: 'Videos',
    viewBuilder: () => Text('Videos'),
  ),
  TabItem(
    title: 'Saved',
    viewBuilder: () => Text('Saved'),
  ),
];

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: navItems.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('WhatsApp Status Saver'),
          backgroundColor: Colors.transparent,
          actions: <Widget>[],
          bottom: TabBar(
            tabs: navItems.map((item) => _buildTabNavItem(item.title)).toList(),
          ),
        ),
        body: TabBarView(
          children: navItems.map((item) => item.viewBuilder()).toList(),
        ),
      ),
    );
  }

  Widget _buildTabNavItem(String title) {
    return Container(
      padding: EdgeInsets.all(12.0),
      child: Text(title.toUpperCase()),
    );
  }
}
