import 'package:share/share.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:whatsapp_status_saver/models/status_item.dart';

final String albumName = 'WhatsApp Status Saver';

Future<void> shareSelectedItems(List<StatusItem> items) async {
  await Share.shareFiles(items.map((item) => item.path).toList(), text: 'Shared via WhatsApp Status Saver, download today!');
}

Future<void> downloadSelectedItems(List<StatusItem> items) async {
  for (var item in items) {
    if (item.type == StatusType.video) {
      print('[INFO] => VIDEO => ${item.path}');
      await GallerySaver.saveVideo(item.path, albumName: albumName);
    } else {
      print('[INFO] => IMAGE => ${item.path}');
      await GallerySaver.saveImage(item.path, albumName: albumName);
    }
  }
}
