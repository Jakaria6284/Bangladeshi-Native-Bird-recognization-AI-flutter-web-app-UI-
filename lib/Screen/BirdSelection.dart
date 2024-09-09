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
  bool _imagesVisible =false; // Control visibility of images

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
                    Text("Indian Pied Starling",style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white
                    ),),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/moyna2.png',
                        height: 600,
                        width: 800,
                        fit: BoxFit.cover,
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 400,
                            height: 300,
                            decoration: BoxDecoration(
                              color: Color(0xA0351E4D),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: Colors.white,
                                style: BorderStyle.solid,
                                width: 2,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Indian Pied Starling (Gracupica contra)",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(color: Colors.white, fontSize: 16),
                                      children: [
                                        TextSpan(
                                          text: "- Common Names: ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        TextSpan(text: "Asian Pied Starling, Pied Myna\n"),
                                        TextSpan(
                                          text: "- Scientific Name: ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        TextSpan(text: "Gracupica contra\n"),
                                        TextSpan(
                                          text: "- Family: ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        TextSpan(text: "Sturnidae\n"),
                                        TextSpan(
                                          text: "- Size: ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        TextSpan(text: "22–24 cm in length\n"),
                                        TextSpan(
                                          text: "- Color: ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        TextSpan(
                                            text:
                                            "Black and white plumage with orange-red patch around eyes\n"),
                                        TextSpan(
                                          text: "- Beak: ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        TextSpan(text: "Yellow with slight orange base"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 400,
                            height: 300,
                            decoration: BoxDecoration(
                              color: Color(0xA0351E4D),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: Colors.white,
                                style: BorderStyle.solid,
                                width: 2,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(color: Colors.white, fontSize: 16),
                                      children: [
                                        TextSpan(
                                          text: "- Habitat: ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        TextSpan(
                                            text:
                                            "Open grasslands, farmlands, urban gardens\n"),
                                        TextSpan(
                                          text: "- Diet: ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        TextSpan(text: "Omnivorous—feeds on insects, fruits, grains, scraps\n"),
                                        TextSpan(
                                          text: "- Social: ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        TextSpan(text: "Often seen in small flocks\n"),
                                        TextSpan(
                                          text: "- Breeding: ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        TextSpan(text: "Breeding season from March to August\n"),
                                        TextSpan(
                                          text: "- Conservation Status: ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        TextSpan(text: "Least Concern\n"),
                                        TextSpan(
                                          text: "- Population: ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        TextSpan(text: "Stable and widely distributed"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),


                    ),
                    Text("Range Map",style: GoogleFonts.roboto(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/map.png',
                        height: 600,
                        width: 800,
                        fit: BoxFit.cover,
                      ),
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