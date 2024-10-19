import 'dart:typed_data';
import 'package:flutter/material.dart';

import '../Model/ImageModel.dart';
import '../Model/ResultModel.dart';
import '../service/apiService.dart';



class BirdViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  ImageModel? _selectedImage;
  ResultModel? _predictionResult;
  bool _isLoading = false;

  ImageModel? get selectedImage => _selectedImage;
  ResultModel? get predictionResult => _predictionResult;
  bool get isLoading => _isLoading;

   //Set the selected image
  void setSelectedImage(Uint8List imageBytes) {
    _selectedImage = ImageModel(imageBytes: imageBytes, fileName: 'bird_image.jpg');
    notifyListeners();
  }

  // Send image to the API using the ApiService
  Future<void> sendImage() async {
    if (_selectedImage == null) return;

    try {
      _isLoading = true;
      notifyListeners();

      // Use ApiService to send the image
      _predictionResult = await _apiService.sendImageToApi(
        _selectedImage!.imageBytes,
        _selectedImage!.fileName,
      );
    } catch (e) {
      print('Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
