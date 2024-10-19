import 'dart:typed_data';

class ImageModel {
  final Uint8List imageBytes;
  final String fileName;

  ImageModel({required this.imageBytes, required this.fileName});
}
