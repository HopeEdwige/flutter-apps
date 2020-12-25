import 'package:flutter/material.dart';

class LoadingOverlay {
  BuildContext context;
  OverlayEntry _overlayEntry;

  void hide() {
    if (_overlayEntry != null) {
      _overlayEntry.remove();
      _overlayEntry = null;
    }
  }

  void show() {
    _overlayEntry = _createOverlay();
    Overlay.of(context).insert(_overlayEntry);
  }

  OverlayEntry _createOverlay() {
    final size = MediaQuery.of(context).size;
    return OverlayEntry(
      builder: (BuildContext context) => Stack(
        children: <Widget>[
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          Positioned(
            top: size.height / 2,
            left: size.width / 2,
            child: CircularProgressIndicator(),
          )
        ],
      ),
    );
  }

  Future<T> during<T>(Future<T> future) {
    show();
    return future.whenComplete(() => hide());
  }

  LoadingOverlay._create(this.context);

  factory LoadingOverlay.of(BuildContext context) {
    return LoadingOverlay._create(context);
  }
}
