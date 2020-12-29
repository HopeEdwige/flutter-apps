import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:whatsapp_status_saver/models/selected_item.dart';
import 'package:whatsapp_status_saver/models/selection_model.dart';

import 'package:whatsapp_status_saver/services/status_service.dart';

class StatusListScreen extends StatefulWidget {
  final StatusType statusType;

  StatusListScreen({Key key, this.statusType}) : super(key: key);

  @override
  StatusListScreenState createState() => new StatusListScreenState();
}

class StatusListScreenState extends State<StatusListScreen> {
  bool _selectionMode;
  List<String> _statusList;

  @override
  void initState() {
    super.initState();

    _statusList = getStatusList(widget.statusType);
    _selectionMode = Provider.of<SelectionModel>(context, listen: false).items.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final bool hasMedia = _statusList.length > 0;

    if (hasMedia) {
      return Container(
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          itemCount: _statusList.length,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          staggeredTileBuilder: (int index) => new StaggeredTile.count(2, 2),
          itemBuilder: (BuildContext context, int index) => ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: getGridTile(index),
          ),
        ),
      );
    }

    return Container();
  }

  Widget getGridTile(int index) {
    return Consumer<SelectionModel>(
      builder: (context, selection, child) {
        final mediaPath = _statusList[index];
        final bool isSelected = selection.hasItem(mediaPath);

        if (_selectionMode) {
          return GridTile(
            header: GridTileBar(
              leading: Icon(
                isSelected ? Icons.check_circle_outline : Icons.radio_button_unchecked,
                color: isSelected ? Colors.green : Colors.black54,
                size: 35,
              ),
            ),
            child: GestureDetector(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _buildMediaListItem(mediaPath),
                  if (isSelected) Positioned.fill(child: Container(color: Colors.black.withOpacity(.6))),
                ],
              ),
              onTap: () {
                setState(() {
                  if (selection.hasItem(mediaPath)) {
                    selection.remove(mediaPath);
                  } else {
                    selection.add(new SelectedItem(path: mediaPath));
                  }

                  if (selection.items.isEmpty) {
                    _selectionMode = false;
                  }
                });
              },
            ),
          );
        }

        return GridTile(
          child: InkResponse(
            child: _buildMediaListItem(mediaPath),
            onLongPress: () {
              setState(() {
                _selectionMode = true;
                selection.add(new SelectedItem(path: mediaPath));
              });
            },
          ),
        );
      },
    );
  }

  Widget _buildMediaListItem(String mediaPath) {
    if (widget.statusType == StatusType.image) {
      return Image.file(File(mediaPath), fit: BoxFit.cover);
    } else {
      return Container(color: Colors.red);
    }
  }
}
