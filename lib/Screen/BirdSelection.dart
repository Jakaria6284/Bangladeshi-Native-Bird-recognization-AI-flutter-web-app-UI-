import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';

import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/Model/ImageModel.dart';

import '../provider/imageProvider.dart';

class BirdSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BirdViewModel(),
      child: Scaffold(
        backgroundColor: const Color(0xFF0C0C13),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: SingleChildScrollView(
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
                                "Upload an image of a bird and let the AI predict the species.",
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
                Consumer<BirdViewModel>(
                  builder: (context, viewModel, child) {
                    Widget content;

                    if (viewModel.selectedImage == null) {
                      content = Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () async {
                              FilePickerResult? result = await FilePicker.platform.pickFiles(
                                type: FileType.image,
                                allowMultiple: false,
                              );
                              if (result != null) {
                                viewModel.setSelectedImage(result.files.single.bytes!);
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
                      content = InkWell(
                        onTap: () async {
                          FilePickerResult? result = await FilePicker.platform.pickFiles(
                            type: FileType.image,
                            allowMultiple: false,
                          );
                          if (result != null) {
                            viewModel.setSelectedImage(result.files.single.bytes!);
                          }
                        },
                        child: Image.memory(
                          viewModel.selectedImage!.imageBytes,
                          fit: BoxFit.cover,
                        ),
                      );
                    }

                    return Column(
                      children: [
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
                          onPressed: viewModel.selectedImage == null
                              ? null
                              : () => viewModel.sendImage(),
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
                        if (viewModel.isLoading) const CircularProgressIndicator(),
                        if (viewModel.predictionResult != null)
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              'Predicted Class: ${viewModel.predictionResult!.predictedClass}\n'
                                  'Confidence: ${viewModel.predictionResult!.confidence.toStringAsFixed(2)}',
                              style: GoogleFonts.roboto(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
