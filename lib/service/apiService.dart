import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Model/ResultModel.dart';


class ApiService {
  final String apiUrl = 'http://127.0.0.1:8000/predict/'; // Your API endpoint

  // Function to send the image to the API
  Future<ResultModel> sendImageToApi(Uint8List imageBytes, String fileName) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      request.files.add(http.MultipartFile.fromBytes('file', imageBytes, filename: fileName));

      var response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await http.Response.fromStream(response);
        final responseJson = json.decode(responseData.body);

        return ResultModel.fromJson(responseJson);
      } else {
        throw Exception('Failed to get prediction: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }
}
