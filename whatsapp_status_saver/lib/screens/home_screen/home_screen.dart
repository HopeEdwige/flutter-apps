import 'dart:ui';

import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:whatsapp_status_saver/models/status_model.dart';
import 'package:whatsapp_status_saver/models/selection_model.dart';

import 'package:whatsapp_status_saver/util/media_utils.dart';
import 'package:whatsapp_status_saver/screens/status_list_screen/status_list_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    StatusModel statusModel = Provider.of<StatusModel>(context);

    if (!this._isInitialized) {
      Future.delayed(Duration.zero, () => statusModel.fetch());
      this._isInitialized = true;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    StatusModel statusModel = Provider.of<StatusModel>(context, listen: true);
    SelectionModel selectionModel = Provider.of<SelectionModel>(context);
    bool hasSelection = selectionModel.isNotEmpty;

    // todo check if WhatsApp doesn't exist and display error screen
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
          actions: hasSelection ? _buildActions(selectionModel) : null,
        ),
        body: TabBarView(
          children: [
            statusModel.images.isEmpty
                ? Center(child: CircularProgressIndicator())
                : Tab(
                    child: StatusListScreen(
                      statusList: statusModel.images,
                      onRefresh: () => _handleRefresh(),
                    ),
                  ),
            Tab(
              child: StatusListScreen(
                statusList: statusModel.videos,
                onRefresh: () => _handleRefresh(),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: hasSelection ? _buildFloatingButton(selectionModel) : null,
      ),
    );
  }

  Widget _buildTabNavItem(String title) {
    return Container(
      child: Text(title.toUpperCase()),
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
    );
  }

  List<Widget> _buildActions(SelectionModel selectionModel) {
    return [
      IconButton(
        icon: Icon(Icons.share_rounded),
        onPressed: () async {
          await shareSelectedItems(selectionModel.items);
          selectionModel.removeAll();
        },
      ),
      IconButton(
        icon: Icon(Icons.download_rounded),
        onPressed: () async {
          await downloadSelectedItems(selectionModel.items);
          selectionModel.removeAll();
          Toast.show('${selectionModel.items.length} downloaded successfully!', context, duration: 3);
        },
      ),
    ];
  }

  Widget _buildFloatingButton(SelectionModel model) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: FloatingActionButton.extended(
        onPressed: () async {
          await shareSelectedItems(model.items);
          model.removeAll();
        },
        icon: Icon(Icons.share_outlined, color: Colors.white),
        label: Text('Share ${model.items.length} files', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigoAccent,
      ),
    );
  }

  Future<void> _handleRefresh() async {
    StatusModel statusModel = Provider.of<StatusModel>(context, listen: false);
    await Future.delayed(Duration(milliseconds: 1000), () => statusModel.fetch());
  }
}
