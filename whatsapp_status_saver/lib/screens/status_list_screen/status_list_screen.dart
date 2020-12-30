import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:whatsapp_status_saver/models/status_item.dart';

import 'package:whatsapp_status_saver/screens/status_list_screen/widgets/status_tile/index.dart';

class StatusListScreen extends StatelessWidget {
  final List<StatusItem> statusList;
  final Function onRefresh;

  StatusListScreen({Key key, this.statusList, this.onRefresh}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (statusList.isNotEmpty) {
      return RefreshIndicator(
        onRefresh: onRefresh,
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          itemCount: statusList.length,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          staggeredTileBuilder: (int index) => new StaggeredTile.count(2, 2),
          itemBuilder: (BuildContext context, int index) {
            final StatusItem statusItem = statusList[index];

            if (statusItem.isReady) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: StatusTile(statusItem),
              );
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      );
    }

    // todo when no media found display a nice message
    return Container();
  }
}
