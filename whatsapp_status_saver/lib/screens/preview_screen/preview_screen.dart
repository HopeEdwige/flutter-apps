import 'dart:io';

import 'package:flutter/material.dart';
import 'package:whatsapp_status_saver/models/status_item.dart';

class PreviewScreen extends StatelessWidget {
  final StatusItem item;

  const PreviewScreen({this.item, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Hero(
                tag: item.path,
                child: Image.file(
                  File(item.path),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
