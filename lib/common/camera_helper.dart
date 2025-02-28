import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraHelper {
  final ImagePicker _picker = ImagePicker();

  Future<File?> showMediaPicker(BuildContext context,
      {bool isVideo = false}) async {
    File? selectedFile;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Select Source"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text("Camera"),
                onTap: () async {
                  Navigator.pop(context);
                  selectedFile = await _pickMedia(ImageSource.camera, isVideo);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text("Gallery"),
                onTap: () async {
                  Navigator.pop(context);
                  selectedFile = await _pickMedia(ImageSource.gallery, isVideo);
                },
              ),
            ],
          ),
        );
      },
    );

    return selectedFile;
  }

  Future<File?> _pickMedia(ImageSource source, bool isVideo) async {
    final XFile? pickedFile = isVideo
        ? await _picker.pickVideo(source: source)
        : await _picker.pickImage(source: source);

    return pickedFile != null ? File(pickedFile.path) : null;
  }
}
