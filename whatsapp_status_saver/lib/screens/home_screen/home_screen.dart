import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:whatsapp_status_saver/models/selected_item.dart';
import 'package:whatsapp_status_saver/models/selection_model.dart';
import 'package:whatsapp_status_saver/services/status_service.dart';

import 'package:whatsapp_status_saver/screens/status_list_screen/status_list_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<SelectedItem> selectedItems = Provider.of<SelectionModel>(context).items;
    bool hasSelection = selectedItems.isNotEmpty;

    // todo check if whatsapp doesnt exist and display error screen
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('WhatsApp Status Saver'),
          backgroundColor: Colors.transparent,
          bottom: TabBar(
            tabs: [
              _buildTabNavItem('Images'),
              _buildTabNavItem('Videos'),
            ],
          ),
          actions: hasSelection ? _buildActions() : null,
        ),
        body: TabBarView(
          children: [
            StatusListScreen(
              statusType: StatusType.image,
            ),
            StatusListScreen(
              statusType: StatusType.video,
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: hasSelection ? _buildFloatingButton(selectedItems) : null,
      ),
    );
  }

  Widget _buildTabNavItem(String title) {
    return Container(
      child: Text(title.toUpperCase()),
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
    );
  }

  List<Widget> _buildActions() {
    return [
      IconButton(icon: Icon(Icons.share_rounded), onPressed: () {}),
      IconButton(icon: Icon(Icons.download_rounded), onPressed: () {}),
    ];
  }

  Widget _buildFloatingButton(List<SelectedItem> selectedItems) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: FloatingActionButton.extended(
        onPressed: () {},
        icon: Icon(Icons.share_outlined, color: Colors.white),
        label: Text('Share ${selectedItems.length} files', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigoAccent,
      ),
    );
  }
}
