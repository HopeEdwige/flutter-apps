import 'dart:io';
import 'package:path/path.dart' as p;

import 'package:thumbnails/thumbnails.dart';
import 'package:whatsapp_status_saver/models/status_item.dart';

final String _mediaPath = '/storage/emulated/0/WhatsApp/Media/.Statuses';
final Directory _rootDir = new Directory(_mediaPath);

/// Checks if directory exists
bool statusDirExists() {
  return _rootDir.existsSync();
}

/// Generates thumbnail for video statuses
Future generateThumbnail(String video) {
  return Thumbnails.getThumbnail(
    videoFile: video,
    imageType: ThumbFormat.PNG,
    quality: 50,
  );
}

/// Returns a list of paths for media files
List<StatusItem> getStatusList() {
  return _rootDir
      .listSync()
      .where((item) => item.path.endsWith('.jpg') || item.path.endsWith('.mp4'))
      .map((item) => item.path)
      .map((path) => new StatusItem(
            path: path,
            type: p.extension(path) == '.jpg' ? StatusType.image : StatusType.video,
          ))
      .toList(growable: false);
}
