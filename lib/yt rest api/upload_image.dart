import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageApi extends StatefulWidget {
  const UploadImageApi({super.key});

  @override
  State<UploadImageApi> createState() => _UploadImageApiState();
}

class _UploadImageApiState extends State<UploadImageApi> {
  final imagePicker = ImagePicker();
  File? image;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title: const Text('Upload Image Api'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [],
      ),
    );
  }
}
