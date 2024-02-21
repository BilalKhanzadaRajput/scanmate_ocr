import 'dart:developer';
import 'dart:io'; // Import for file operations

import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:path_provider/path_provider.dart';

class RecognizePage extends StatefulWidget {
  final String? path;
  const RecognizePage({Key? key, this.path}) : super(key: key);

  @override
  State<RecognizePage> createState() => _RecognizePageState();
}

class _RecognizePageState extends State<RecognizePage> {
  bool _isBusy = true;
  String _recognizedText = '';
  String _notes = ''; // Variable to store notes

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
        title: const Text(
          "Recognized Text",
          style: TextStyle(color: Colors.white),
        ),
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
              onChanged: (value) {
                // Update notes when text changes
                setState(() {
                  _notes = value;
                });
              },
              decoration: InputDecoration(
                hintText: "Add notes here...",
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(12),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Call method to save text and notes
                saveTextAndNotes();
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
      final RecognizedText recognizedText =
      await textRecognizer.processImage(inputImage);
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

  void saveTextAndNotes() async {
    try {
      String combinedText = "$_recognizedText\n$_notes";
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/recognized_text.txt');
      await file.writeAsString(combinedText);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Text and notes saved successfully'),
        ),
      );
    } catch (e) {
      log("Error saving text and notes: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save text and notes'),
        ),
      );
    }
  }

}
