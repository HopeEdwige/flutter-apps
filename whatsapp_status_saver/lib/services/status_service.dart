import 'dart:io';

enum StatusType { image, video }

final String _mediaPath = '/storage/emulated/0/WhatsApp/Media/.Statuses';
final Directory _rootDir = new Directory(_mediaPath);

/// Checks if directory exists
bool statusDirExists() {
  return _rootDir.existsSync();
}

/// Returns a list of paths for media files depending on the selected type
List<String> getStatusList(StatusType type) {
  final String extension = type == StatusType.image ? '.jpg' : '.mp4';
  return _rootDir.listSync().map((item) => item.path).where((item) => item.endsWith(extension)).toList(growable: false);
}
