import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

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

  Future<void> uploadImage() async {
    setState(() {
      showSpinner = true;
    });

    var stream = http.ByteStream(image!.openRead());
    stream.cast();

    var length = await image!.length();

    var url = Uri.parse('https://fakestoreapi.com/products');

    var request = http.MultipartRequest('POST', url);

    request.fields['title'] = 'Static title';

    var multiPort = http.MultipartFile('image', stream, length);
    request.files.add(multiPort);
    var response = await request.send();

    if (response.statusCode == 200) {
      print('Image uploaded');
      setState(() {
        showSpinner = false;
      });
    } else {
      print('failed');
      setState(() {
        showSpinner = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          title: const Text(
            'Upload Image Api',
            style: TextStyle(color: Colors.white),
          ),
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
            const SizedBox(
              height: 150,
            ),
            GestureDetector(
              onTap: () {
                uploadImage();
              },
              child: Container(
                height: 50,
                width: 200,
                color: Colors.deepPurple,
                child: const Center(
                    child: Text(
                  'Upload Image',
                  style: TextStyle(color: Colors.white),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
