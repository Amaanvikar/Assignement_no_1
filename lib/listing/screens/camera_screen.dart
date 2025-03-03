import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final ImagePicker _picker = ImagePicker();
  List<Map<String, dynamic>> _mediaList = [];

  Future<void> _pickMedia(ImageSource source, {required bool isVideo}) async {
    try {
      if (isVideo) {
        final XFile? pickedVideo = await _picker.pickVideo(source: source);
        if (pickedVideo != null) {
          setState(() {
            _mediaList.add({"path": pickedVideo.path, "isVideo": true});
          });
        }
      } else {
        if (source == ImageSource.camera) {
          List<Map<String, dynamic>> capturedImages = [];
          bool takeMorePhotos = true;

          while (takeMorePhotos) {
            final XFile? pickedImage =
                await _picker.pickImage(source: ImageSource.camera);
            if (pickedImage != null) {
              capturedImages.add({"path": pickedImage.path, "isVideo": false});
            }

            takeMorePhotos = await _showContinueDialog();
          }

          setState(() {
            _mediaList.addAll(capturedImages);
          });
        } else {
          final List<XFile>? pickedImages = await _picker.pickMultiImage();
          if (pickedImages != null) {
            setState(() {
              _mediaList.addAll(pickedImages
                  .map((image) => {"path": image.path, "isVideo": false})
                  .toList());
            });
          }
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to pick media: $e")),
      );
    }
  }

  Future<bool> _showContinueDialog() async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Take Another Photo?"),
            content: Text("Do you want to capture another image?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text("No"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text("Yes"),
              ),
            ],
          ),
        ) ??
        false;
  }

  void _showMediaPickerDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.image, color: Colors.blue),
                title: const Text('Take Photo'),
                onTap: () {
                  Navigator.pop(context);
                  _pickMedia(ImageSource.camera, isVideo: false);
                },
              ),
              ListTile(
                leading: const Icon(Icons.image, color: Colors.green),
                title: const Text('Choose Images from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickMedia(ImageSource.gallery, isVideo: false);
                },
              ),
              ListTile(
                leading: const Icon(Icons.image, color: Colors.red),
                title: const Text('Record Video'),
                onTap: () {
                  Navigator.pop(context);
                  _pickMedia(ImageSource.camera, isVideo: true);
                },
              ),
              ListTile(
                leading: Icon(Icons.image, color: Colors.purple),
                title: const Text('Choose Video from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickMedia(ImageSource.gallery, isVideo: true);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Camera & Media Picker")),
      body: Column(
        children: [
          ElevatedButton.icon(
            onPressed: _showMediaPickerDialog,
            icon: const Icon(Icons.add_a_photo),
            label: const Text('Add Media'),
          ),
          Expanded(
            child: _mediaList.isEmpty
                ? Center(child: Text("No media selected"))
                : ListView.builder(
                    itemCount: _mediaList.length,
                    itemBuilder: (context, index) {
                      final media = _mediaList[index];
                      return ListTile(
                        leading: media["isVideo"]
                            ? Icon(Icons.videocam, color: Colors.red)
                            : Image.file(File(media["path"]),
                                width: 50, height: 50, fit: BoxFit.cover),
                        title: Text(media["path"]),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
