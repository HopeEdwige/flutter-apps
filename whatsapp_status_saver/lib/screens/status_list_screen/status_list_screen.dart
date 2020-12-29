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
  bool _isLoading;
  List<String> _statusList;
  Map<String, String> _thumbnails = new Map();

  @override
  void initState() {
    super.initState();
    _statusList = getStatusList(widget.statusType);
    _isLoading = widget.statusType == StatusType.video;

    if (widget.statusType == StatusType.video) {
      Future(() => _generateThumbs(_statusList)).then((value) {
        setState(() {
          _thumbnails = value;
          _isLoading = false;
        });
      });
    }
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
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Tile(
                    thumbnail: widget.statusType == StatusType.video ? _thumbnails[_statusList[index]] : _statusList[index],
                  ),
          ),
        ),
      );
    }

    return Container();
  }

  _generateThumbs(statusList) async {
    Map<String, String> map = new Map();

    for (var i = 0; i < _statusList.length; i++) {
      final path = _statusList[i];
      if (!_thumbnails.containsKey(path)) {
        map[path] = await generateThumbnail(path);
      }
    }

    return Future.value(map);
  }
}

class Tile extends StatelessWidget {
  final String thumbnail;
  final StatusType statusType;

  const Tile({this.statusType, this.thumbnail});

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectionModel>(
      builder: (context, selection, child) {
        final mediaPath = thumbnail;
        final bool isSelected = selection.hasItem(mediaPath);

        if (selection.items.isNotEmpty) {
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
                if (selection.hasItem(mediaPath)) {
                  selection.remove(mediaPath);
                } else {
                  selection.add(new SelectedItem(path: mediaPath));
                }
              },
            ),
          );
        }

        return GridTile(
          child: InkResponse(
            child: _buildMediaListItem(mediaPath),
            onLongPress: () {
              selection.add(new SelectedItem(path: mediaPath));
            },
          ),
        );
      },
    );
  }

  Widget _buildMediaListItem([mediaPath]) {
    return Hero(
      tag: mediaPath,
      child: Image.file(File(mediaPath), fit: BoxFit.cover),
    );
  }
}
