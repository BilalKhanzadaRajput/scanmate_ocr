import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scanmate_ocr/Screens/recongnization_page.dart';
import 'package:scanmate_ocr/Screens/text_to_speech.dart';
import 'package:scanmate_ocr/Utils/image_cropper_page.dart';
import 'package:scanmate_ocr/Utils/image_picker_class.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Scan Mate",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20, // Adjust the font size as needed
              color: Colors.white, // Adjust the text color as needed
            ),
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: AssetImage(
                        'assets/IT.png'), // Replace with your image path
                    fit: BoxFit.cover,
                  ),
                ),
                child: InkWell(
                  onTap: _showCameraGalleryMenu,
                ),
                width: MediaQuery.of(context).size.width - 32,
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.green,
                  image: const DecorationImage(
                    image: AssetImage(
                        'assets/h.png'), // Replace with your image path
                    fit: BoxFit.cover,
                  ), // Change color to your preference
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TextToSpeech()),
                    );
                  },
                ),
                width: MediaQuery.of(context).size.width - 32,
                height: MediaQuery.of(context).size.height * 0.3,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showCameraGalleryMenu,
        label: const Text("Scan Photo"),
        icon: const Icon(Icons.add),
      ),
    );
  }

  // Function to show camera/gallery menu
  void _showCameraGalleryMenu() {
    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(100, 100, 100, 100),
      items: <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'camera',
          child: ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text('Take a photo'),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'gallery',
          child: ListTile(
            leading: Icon(Icons.photo_library),
            title: Text('Choose from gallery'),
          ),
        ),
      ],
    ).then((String? value) {
      if (value == 'camera') {
        _pickImageFromCamera();
      } else if (value == 'gallery') {
        _pickImageFromGallery();
      }
    });
  }

  // Function to pick image from camera
  void _pickImageFromCamera() {
    log("Camera");
    pickImage(source: ImageSource.camera).then((value) {
      if (value != null && value.isNotEmpty) {
        _navigateToRecognizePage(value);
      }
    });
  }

  // Function to pick image from gallery
  void _pickImageFromGallery() {
    log("Gallery");
    pickImage(source: ImageSource.gallery).then((value) {
      if (value != null && value.isNotEmpty) {
        _navigateToRecognizePage(value);
      }
    });
  }

  // Function to navigate to RecognizePage
  void _navigateToRecognizePage(String imagePath) {
    imageCropperView(imagePath, context).then((croppedImagePath) {
      if (croppedImagePath != null && croppedImagePath.isNotEmpty) {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (_) => RecognizePage(
              path: croppedImagePath,
            ),
          ),
        );
      }
    });
  }
}
