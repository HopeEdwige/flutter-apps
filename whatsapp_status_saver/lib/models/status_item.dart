import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:whatsapp_status_saver/services/status_service.dart';

enum StatusType { image, video }

class StatusItem {
  final String path;
  final StatusType type;

  String title;
  bool isLoading = false;
  String thumbnailPath;

  StatusItem({
    @required this.path,
    @required this.type,
    isLoading,
    thumbnailPath,
  }) {
    this.title = p.basename(this.path);
    this.thumbnailPath = thumbnailPath ?? this.path;

    if (this.type == StatusType.video) {
      buildThumbnail();
    }
  }

  bool get isReady => !this.isLoading && this.thumbnailPath.isNotEmpty;

  @override
  String toString() {
    return 'StatusItem( path=${this.path}, type=${this.type}, thumbnailPath=${this.thumbnailPath} )';
  }

  buildThumbnail() async {
    this.isLoading = true;
    try {
      this.thumbnailPath = await generateThumbnail(path);
    } catch (e) {
      print('[ERROR] StatusItem => Failed to generate thumbnail $e');
    } finally {
      this.isLoading = false;
    }
  }
}
