import 'package:flutter/material.dart';
import 'package:weight_tracker/models/weight.dart';
import 'package:weight_tracker/widgets/history_list/history_list.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          backgroundColor: theme.scaffoldBackgroundColor,
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  size: 28,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            )
          ],
          title: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'History',
              style: TextStyle(fontSize: theme.textTheme.headline4.fontSize),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: HistoryList(items: []),
        ),
      ),
    );
  }
}
