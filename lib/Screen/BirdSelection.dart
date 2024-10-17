import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'dart:typed_data'; // For ByteData
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http; // Import http package

class BirdSelection extends StatefulWidget {
  const BirdSelection({super.key});

  @override
  _BirdSelectionState createState() => _BirdSelectionState();
}

class _BirdSelectionState extends State<BirdSelection> {
  Uint8List? selectedImageBytes; // Use Uint8List to store image bytes

  final ScrollController _scrollController = ScrollController(); // Scroll controller to control scrolling

  String? predictionResult; // Store prediction result








  // Function to send image to the API
  Future<void> sendImage(Uint8List imageBytes) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://127.0.0.1:8000/predict/'), // Your FastAPI endpoint
      );

      // Attach the image to the request
      request.files.add(http.MultipartFile.fromBytes(
        'file', // This should match the parameter name in FastAPI
        imageBytes,
        filename: 'bird_image.jpg', // Change as needed
      ));

      // Send the request and await the response
      var response = await request.send();

      // Check for response status
      if (response.statusCode == 200) {
        // If the server returns an OK response, parse the response body
        final responseData = await http.Response.fromStream(response);
        //final responseJson = responseData.body;
        final responseJson = json.decode(responseData.body);
        setState(() {
         // predictionResult = responseJson; // Store the result to display it
          predictionResult = 'Predicted Class: ${responseJson['predicted_class']}\n\n'
              'Confidence: ${responseJson['confidence'].toStringAsFixed(2)}';
        });
      } else {
        // Handle error response
        setState(() {
          predictionResult = 'Error: ${response.statusCode} - ${response.reasonPhrase}';
        });
      }
    } catch (e) {
      setState(() {
        predictionResult = 'Error occurred: $e';
      });
    }
  }














  @override
  Widget build(BuildContext context) {
    Widget content;

    if (selectedImageBytes == null) {
      content = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () async {
              //File picking from folder
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.image, // Restrict to image files
                allowMultiple: false,
              );

              if (result != null) {
                setState(() {
                  selectedImageBytes = result.files.single.bytes;
                });
              }
            },
            icon: const Icon(Icons.add_circle_outline, size: 80),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Text(
              "Click to Select Bird",
              style: GoogleFonts.roboto(
                fontSize: 30,
                fontWeight: FontWeight.w100,
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
    } else {
      content = SizedBox.expand(
        child: InkWell(
          onTap: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.image, // Restrict to image files
              allowMultiple: false,
            );

            if (result != null) {
              setState(() {
                selectedImageBytes = result.files.single.bytes;
              });
            }
          },
          child: Image.memory(
            selectedImageBytes!,
            fit: BoxFit.cover, // Ensure the image fits inside the container
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0C0C13),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40, left: 50),
                          child: Text(
                            "Identify Bangladeshi Native Bird Using AI",
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w700,
                              fontSize: 35,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          width: 500,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20, left: 50),
                            child: Text(
                              "Below is a free classifier to identify birds. Just upload your image, and our AI will predict what bird it is - in just seconds.",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w300,
                                fontSize: 25,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40, right: 40),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/finalbard.png',
                          height: 300,
                          width: 500,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Container(
                height: 200,
                width: 400,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: content,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (selectedImageBytes != null) {
                    sendImage(selectedImageBytes!); // Call the function to send the image
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFFFFF),
                  padding: const EdgeInsets.all(20),
                ),
                child: Text(
                  "Click to recognize",
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Display the prediction result
              if (predictionResult != null)
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    predictionResult!,
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              const SizedBox(height: 40),
              // All content under this has been removed
            ],
          ),
        ),
      ),
    );
  }
}
