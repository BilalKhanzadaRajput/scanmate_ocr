import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scanmate_ocr/Screens/Home_screen.dart';

import 'package:scanmate_ocr/Utils/Widgets/modal_dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
