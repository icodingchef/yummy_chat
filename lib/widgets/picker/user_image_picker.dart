import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  //const UserImagePicker({Key? key}) : super(key: key);
  UserImagePicker(this.imagePickFn);

  final void Function(File? pickedImage) imagePickFn;

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;

  void _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImageFile = await imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150
    );
    setState(() {
      if (pickedImageFile != null) {
        _pickedImage = File(pickedImageFile.path);
      }
    });
    widget.imagePickFn(_pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage!) : null,
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: Icon(
            Icons.image,
            color: Colors.redAccent,
          ),
          label: Text(
            'Add image',
            style: TextStyle(color: Colors.redAccent),
          ),
        ),
      ],
    );
  }
}
