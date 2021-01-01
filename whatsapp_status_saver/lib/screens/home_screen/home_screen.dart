import 'dart:ui';

import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:whatsapp_status_saver/models/status_model.dart';
import 'package:whatsapp_status_saver/models/selection_model.dart';
import 'package:whatsapp_status_saver/screens/not_found_screen/index.dart';

import 'package:whatsapp_status_saver/util/media_utils.dart';
import 'package:whatsapp_status_saver/screens/status_list_screen/status_list_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  bool _isInitialized = false;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    StatusModel statusModel = Provider.of<StatusModel>(context);

    if (!this._isInitialized) {
      Future.delayed(Duration.zero, () {
        try {
          statusModel.fetch();
        } catch (e) {
          print('[ERROR] HomeScreen => Failed to load status => $e}');
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => NotFoundScreen(),
            ),
            (route) => false,
          );
        } finally {
          setState(() {
            _isLoading = false;
          });
        }
      });
      this._isInitialized = true;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    StatusModel statusModel = Provider.of<StatusModel>(context, listen: true);
    SelectionModel selectionModel = Provider.of<SelectionModel>(context);
    bool hasSelection = selectionModel.isNotEmpty;

    return WillPopScope(
      onWillPop: () {
        if (selectionModel.isNotEmpty) {
          selectionModel.removeAll();
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: _buildAppBar(hasSelection, selectionModel),
          body: TabBarView(children: _buildTabViewItems(statusModel)),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: hasSelection ? _buildFloatingButton(selectionModel) : null,
        ),
      ),
    );
  }

  AppBar _buildAppBar(bool hasSelection, SelectionModel selectionModel) {
    if (hasSelection) {
      return AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => selectionModel.removeAll(),
        ),
        title: Text('${selectionModel.items.length} items selected'),
        backgroundColor: Colors.transparent,
        bottom: TabBar(
          tabs: [
            _buildTabNavItem('Images', selectionModel.images.length),
            _buildTabNavItem('Videos', selectionModel.videos.length),
          ],
        ),
        actions: _buildActions(selectionModel),
      );
    }

    return AppBar(
      title: Text('WhatsApp Status Saver'),
      backgroundColor: Colors.transparent,
      bottom: TabBar(
        tabs: [
          _buildTabNavItem('Images'),
          _buildTabNavItem('Videos'),
        ],
      ),
    );
  }

  Widget _buildTabNavItem(String title, [int selectedCount = 0]) {
    final ThemeData theme = Theme.of(context);
    EdgeInsets containerPadding = const EdgeInsets.symmetric(
      vertical: 16.0,
      horizontal: 8,
    );
    List<Widget> rowItems = [
      Text(title.toUpperCase()),
    ];

    if (selectedCount != 0) {
      containerPadding = const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 8,
      );
      rowItems.add(Container(
        padding: const EdgeInsets.only(
          left: 8,
        ),
        child: Container(
          child: Text('$selectedCount'),
          padding: const EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 12,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: theme.chipTheme.backgroundColor,
          ),
        ),
      ));
    }

    return Container(
      padding: containerPadding,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: rowItems),
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
          try {
            await downloadSelectedItems(selectionModel.items);
            Toast.show('${selectionModel.items.length} downloaded successfully!', context, duration: 3);
          } catch (e) {
            Toast.show('Failed to download, please refresh and try again!', context, duration: 3);
          } finally {
            selectionModel.removeAll();
          }
        },
      ),
    ];
  }

  List<Widget> _buildTabViewItems(StatusModel statusModel) {
    if (_isLoading) {
      return [
        Center(child: CircularProgressIndicator()),
        Center(child: CircularProgressIndicator()),
      ];
    }

    final ThemeData theme = Theme.of(context);
    return [
      statusModel.images.isEmpty
          ? Center(
              child: Text(
                'No image status found.',
                style: theme.textTheme.subtitle1,
              ),
            )
          : Tab(
              child: StatusListScreen(
                statusList: statusModel.images,
                onRefresh: () => _handleRefresh(),
              ),
            ),
      statusModel.videos.isEmpty
          ? Center(
              child: Text(
                'No video status found.',
                style: theme.textTheme.subtitle1,
              ),
            )
          : Tab(
              child: StatusListScreen(
                statusList: statusModel.videos,
                onRefresh: () => _handleRefresh(),
              ),
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
