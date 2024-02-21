import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scanmate_ocr/Utils/Widgets/modal_dialog.dart';
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
        title: const Center(child: Text("ScanMate",style: TextStyle(fontWeight: FontWeight.bold,),)),
        backgroundColor: Colors.blue,
      ),
      body: const Card(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          imagePickerModel(
            context: context,
            onCameraTap: () {
              log("Camera");
              pickImage(source: ImageSource.camera).then((value) {
                if(value != ''){

                }

              });
            },
            onGalleryTap: () {
              log("Gallery");
              pickImage(source: ImageSource.gallery).then((value) {
                if(value != ''){

                }


              });
            },
          );
        },
        label: const Text("Scan Photo"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}