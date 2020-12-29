import 'dart:io';
import 'package:thumbnails/thumbnails.dart';

enum StatusType { image, video }

final String _mediaPath = '/storage/emulated/0/WhatsApp/Media/.Statuses';
final Directory _rootDir = new Directory(_mediaPath);

/// Checks if directory exists
bool statusDirExists() {
  return _rootDir.existsSync();
}

/// Generates thumbnail for video statuses
Future generateThumbnail(String video) async {
  return await Thumbnails.getThumbnail(
    videoFile: video,
    imageType: ThumbFormat.PNG,
    quality: 50,
  );
}

/// Returns a list of paths for media files depending on the selected type
List<String> getStatusList(StatusType type) {
  final String extension = type == StatusType.image ? '.jpg' : '.mp4';
  return _rootDir.listSync().map((item) => item.path).where((item) => item.endsWith(extension)).toList(growable: false);
}
