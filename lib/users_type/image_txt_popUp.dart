import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled4/services/firebase_services.dart';


class ImageTextPopup extends StatefulWidget {
  @override
  _ImageTextPopupState createState() => _ImageTextPopupState();
}

class _ImageTextPopupState extends State<ImageTextPopup> {
  File? _image;
  final _textController = TextEditingController();

  final FirestoreService _firebaseService = FirestoreService();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }




  Future<void> _getImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image, // Specify the type of file to pick (image in this case)
      allowMultiple: false, // Allow only one file to be picked
    );

    if (result != null) {
      final file = result.files.single;
      setState(() {
        _image = File(file.path!);
      });
    }
  }


  Future<void> _saveData() async {
    if (_image == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please upload an image.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    try {
      final String text = _textController.text.trim();
      final String imageName = 'images/${DateTime.now().millisecondsSinceEpoch}.jpg';

      final imageURL = await _firebaseService.uploadImage(_image!, imageName);
      final userData = await _firebaseService.getUser();
      var password;
      var type;
      var email;
      if (userData != null) {
        password = userData['password'];
         type = userData['type'];
         email=userData['email'];
        // Now you have email, password, and type, do whatever you need with them
      } else {
        print('User not found');
      }

      // Get the user's email from somewhere


      // Call the FirestoreService function to save user data along with image URL
      await _firebaseService.saveUserDataWithImage( password, type, text, _image!);

      Navigator.pop(context); // Close the pop-up
    } catch (e) {
      print('Error saving data: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Upload Image and Add Text'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _textController,
            decoration: InputDecoration(labelText: 'Enter text'),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton.icon(
                onPressed: () => _getImage(),
                icon: Icon(Icons.photo_library),
                label: Text('Gallery'),
              ),
              // ElevatedButton.icon(
              //   onPressed: () => _getImage(),
              //   icon: Icon(Icons.camera_alt),
              //   label: Text('Camera'),
              // ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close the pop-up
          },
          child: Text('Close'),
        ),
        ElevatedButton(
          onPressed: _saveData,
          child: Text('Save'),
        ),
      ],
    );
  }
}
