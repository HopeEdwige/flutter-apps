import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker/models/session.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Consumer<Session>(
      builder: (context, session, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Welcome ${session.user.name},', style: theme.textTheme.headline5.copyWith(fontWeight: FontWeight.w500)),
            // todo nav/share
          ],
        );
      },
    );
  }
}
