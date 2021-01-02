import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker/models/session.dart';

class Header extends StatelessWidget {
  final String name;

  Header({Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Welcome $name,', style: theme.textTheme.headline5.copyWith(fontWeight: FontWeight.w500)),
        // todo nav/share
      ],
    );
  }
}
