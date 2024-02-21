import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class RecognizePage extends StatefulWidget {
  final String? path;
  const RecognizePage({Key? key, this.path}) : super(key: key);

  @override
  State<RecognizePage> createState() => _RecognizePageState();
}

class _RecognizePageState extends State<RecognizePage> {
  bool _isBusy = true;
  String _recognizedText = '';

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    processImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recognized Text",style: TextStyle(
          color: Colors.white
        ),),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: _isBusy
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _recognizedText,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              maxLines: 3,
              controller: controller,
              decoration: InputDecoration(
                hintText: "Add notes here...",
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(12),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement save functionality
              },
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }

  void processImage() async {
    final InputImage inputImage = InputImage.fromFilePath(widget.path!);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    setState(() {
      _isBusy = true;
    });

    log("Processing image: ${inputImage.filePath}");

    try {
      final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
      setState(() {
        _recognizedText = recognizedText.text;
      });
    } catch (e) {
      log("Text recognition error: $e");
    } finally {
      // End busy state
      setState(() {
        _isBusy = false;
      });
    }
  }
}
