import 'package:permission_handler/permission_handler.dart';

Future<void> requestPermissions() async {
  // Check and request for storage permission
  if (await Permission.storage.isDenied) {
    await Permission.storage.request();
  }

  // Check and request for camera permission
  if (await Permission.camera.isDenied) {
    await Permission.camera.request();
  }

  // Android 13+ needs specific permissions for images, videos, and audio
  if (await Permission.photos.isDenied) {
    await Permission.photos.request();
  }
}