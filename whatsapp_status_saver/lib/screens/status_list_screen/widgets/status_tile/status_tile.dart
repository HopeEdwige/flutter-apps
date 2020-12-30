import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:whatsapp_status_saver/models/status_item.dart';
import 'package:whatsapp_status_saver/models/selection_model.dart';

class StatusTile extends StatelessWidget {
  final StatusItem statusItem;

  const StatusTile(this.statusItem, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectionModel>(
      builder: (context, selection, child) {
        final bool isSelected = selection.hasItem(statusItem);

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
                  _buildMediaListItem(statusItem.thumbnailPath),
                  if (isSelected) Positioned.fill(child: Container(color: Colors.black.withOpacity(.6))),
                ],
              ),
              onTap: () => selection.toggle(statusItem),
            ),
          );
        }

        return GridTile(
          child: InkResponse(
            child: _buildMediaListItem(statusItem.thumbnailPath),
            onLongPress: () => selection.add(statusItem),
          ),
        );
      },
    );
  }

  Widget _buildMediaListItem(mediaPath) {
    return Hero(
      tag: mediaPath,
      child: Image.file(File(mediaPath), fit: BoxFit.cover),
    );
  }
}
