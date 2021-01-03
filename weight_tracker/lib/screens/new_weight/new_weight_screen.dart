import 'package:flutter/material.dart';
import 'package:weight_tracker/screens/new_weight/widgets/calendar/calendar.dart';

class NewWeightScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;

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
              'New Weight',
              style: TextStyle(fontSize: theme.textTheme.headline4.fontSize),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: SafeArea(
          child: Container(
            child: Column(
              children: [
                Calendar(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
