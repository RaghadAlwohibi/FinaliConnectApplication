import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Im;

Future<File> compressImage(File file, String id) async {
  final tempDir = await getTemporaryDirectory();
  final path = tempDir.path;
  Im.Image imageFile = Im.decodeImage(file.readAsBytesSync());
  final compressedImageFile = File('$path/img_$id.jpg')
    ..writeAsBytesSync(Im.encodeJpg(imageFile, quality: 85));

  return compressedImageFile;
}
