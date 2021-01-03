import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String name;

  Header({Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
        gradient: new LinearGradient(
          begin: const Alignment(0.0, -1.0),
          end: const Alignment(0.0, 0.2),
          colors: <Color>[
            theme.colorScheme.background.withOpacity(.2),
            theme.colorScheme.background.withOpacity(.4),
            theme.colorScheme.background.withOpacity(.8),
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Welcome $name,', style: theme.textTheme.headline5.copyWith(fontWeight: FontWeight.w500)),
          // todo nav/share
        ],
      ),
    );
  }
}
