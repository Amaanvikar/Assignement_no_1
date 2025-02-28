import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  String? _mediaPath;
  bool _isVideo = false;
  final ImagePicker _picker = ImagePicker();
  VideoPlayerController? _videoController;

  // Variable to store saved media path
  String? _savedMediaPath;

  // Method to pick media from camera or gallery
  Future<void> _pickMedia(ImageSource source, {required bool isVideo}) async {
    try {
      final XFile? pickedFile = isVideo
          ? await _picker.pickVideo(source: source)
          : await _picker.pickImage(source: source);

      if (pickedFile != null) {
        setState(() {
          _mediaPath = pickedFile.path;
          _isVideo = isVideo;
        });

        // Initialize video player if it's a video
        if (isVideo) {
          _initializeVideoPlayer(pickedFile.path);
        }

        print("Picked Media Path: $_mediaPath");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to pick media: $e")),
      );
    }
  }

  // Method to initialize video player for playing videos
  void _initializeVideoPlayer(String videoPath) {
    _videoController?.dispose();
    _videoController = VideoPlayerController.file(File(videoPath))
      ..initialize().then((_) {
        setState(() {});
        _videoController!.play();
      });
  }

  // Method to save media path (this can be used for API calls)
  void _saveMediaPath() {
    setState(() {
      _savedMediaPath = _mediaPath;
    });
    // You can now use `_savedMediaPath` for API calls
    print("Saved Media Path: $_savedMediaPath");
  }

  // Show bottom sheet dialog for media selection (image or video)
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
                leading: const Icon(Icons.camera_alt, color: Colors.blue),
                title: const Text('Take Photo'),
                onTap: () {
                  Navigator.pop(context);
                  _pickMedia(ImageSource.camera, isVideo: false);
                },
              ),
              ListTile(
                leading: const Icon(Icons.image, color: Colors.green),
                title: const Text('Choose Image from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickMedia(ImageSource.gallery, isVideo: false);
                },
              ),
              ListTile(
                leading: const Icon(Icons.videocam, color: Colors.red),
                title: const Text('Record Video'),
                onTap: () {
                  Navigator.pop(context);
                  _pickMedia(ImageSource.camera, isVideo: true);
                },
              ),
              ListTile(
                leading: const Icon(Icons.video_library, color: Colors.purple),
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
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Camera & Video Screen")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _mediaPath != null
                ? _isVideo
                    ? _videoController != null &&
                            _videoController!.value.isInitialized
                        ? Column(
                            children: [
                              AspectRatio(
                                aspectRatio:
                                    _videoController!.value.aspectRatio,
                                child: VideoPlayer(_videoController!),
                              ),
                              IconButton(
                                icon: Icon(
                                  _videoController!.value.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _videoController!.value.isPlaying
                                        ? _videoController!.pause()
                                        : _videoController!.play();
                                  });
                                },
                              ),
                            ],
                          )
                        : const CircularProgressIndicator()
                    : Image.file(
                        File(_mediaPath!),
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      )
                : ElevatedButton.icon(
                    onPressed: _showMediaPickerDialog,
                    icon: const Icon(Icons.add_a_photo),
                    label: const Text('Add Media'),
                  ),
            // Save button to store media path for later use
            if (_mediaPath != null)
              ElevatedButton(
                onPressed: _saveMediaPath,
                child: const Text('Save Media Path'),
              ),
            // Display the saved media path
            if (_savedMediaPath != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Saved Media Path: $_savedMediaPath',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
