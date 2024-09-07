import 'package:file_picker/file_picker.dart';
import 'dart:typed_data'; // For ByteData
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BirdSelection extends StatefulWidget {
  const BirdSelection({super.key});

  @override
  _BirdSelectionState createState() => _BirdSelectionState();
}

class _BirdSelectionState extends State<BirdSelection> {
  Uint8List? selectedImageBytes; // Use Uint8List to store image bytes
  final ScrollController _scrollController = ScrollController(); // Scroll controller to control scrolling
  bool _imagesVisible = true; // Control visibility of images

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (selectedImageBytes == null) {
      print('No image selected');
      content = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.image, // Restrict to image files
                allowMultiple: false,
              );

              if (result != null) {
                setState(() {
                  selectedImageBytes = result.files.single.bytes;
                  print('Image selected with ${selectedImageBytes!.length} bytes');
                });
              } else {
                print('No image selected');
              }
            },
            icon: const Icon(Icons.add_circle_outline, size: 80,),
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
      print('Image set with ${selectedImageBytes!.length} bytes');
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
                print('Image selected with ${selectedImageBytes!.length} bytes');
              });
            } else {
              print('No image selected');
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
          controller: _scrollController, // Attach the scroll controller
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
              const SizedBox(height: 40,),
              // Container for image or icon button
              Container(
                height: 200,
                width: 400,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    style: BorderStyle.solid,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: content, // Show content based on if-else condition
              ),
              const SizedBox(height: 20,),
              // Recognize Button
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _imagesVisible = true; // Show images when button is pressed
                  });

                  // Use WidgetsBinding to make sure scrolling happens after visibility update
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent,
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeInOut,
                    );
                  });
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
              const SizedBox(height: 40,),
              // Images to recognize (visible after button press)
              Visibility(
                visible: _imagesVisible, // Control visibility based on button press
                child: Column(
                  children: [
                    Image.asset(
                      'assets/moyna3.jpg',
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 20,),
                    Image.asset(
                      'assets/moyna3.jpg',
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 20,),
                    Image.asset(
                      'assets/moyna3.jpg',
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
