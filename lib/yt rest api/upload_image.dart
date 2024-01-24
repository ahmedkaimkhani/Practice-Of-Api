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

  getImage() async {
    final imageFile = await imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 80);

    if (imageFile != null) {
      image = File(imageFile.path);
      setState(() {});
    } else {
      print('no image selected');
    }
  }

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
        children: [
          GestureDetector(
            onTap: () {
              getImage();
            },
            child: Container(
                child: image == null
                    ? const Center(
                        child: Text('Pick Image'),
                      )
                    : Container(
                        child: Center(
                          child: Image.file(
                            File(image!.path).absolute,
                            height: 120,
                            width: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )),
          ),
        ],
      ),
    );
  }
}
