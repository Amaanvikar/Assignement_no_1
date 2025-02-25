import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';

class VideoCompressedScreen extends StatefulWidget {
  const VideoCompressedScreen({super.key, required this.videoUrl});
  final String videoUrl;

  @override
  State<VideoCompressedScreen> createState() => _VideoCompressedScreenState();
}

class _VideoCompressedScreenState extends State<VideoCompressedScreen> {
  final ImagePicker picker = ImagePicker();
  File? _videoFile;
  VideoPlayerController? videoController;
  File? _compressedVideoFile;

  // Future<Video?> fetchVideo() async {
  //   final String url =
  //       'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4';

  //   try {
  //     final response = await http.get(Uri.parse(url));

  //     if (response.statusCode == 200) {
  //       Map<String, dynamic> data = json.decode(response.body);
  //       return Video.fromJson(data);
  //     } else {
  //       throw Exception('Failed to load video');
  //     }
  //   } catch (e) {
  //     print('Error fetching video: $e');
  //     return null;
  //   }
  // }

  Future<void> _pickVideo(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();

    // Pick video from gallery
    final XFile? video = await _picker.pickVideo(
      source: source,
    );

    if (video != null) {
      setState(() {
        _videoFile = File(video.path);
        videoController = VideoPlayerController.file(_videoFile!)
          ..initialize().then((_) {
            setState(() {});
            videoController?.play();
          });
      });
      // print('Video Path: ${_videoFile!.path}');
      await _compressVideo(_videoFile!);
    } else {
      print('No video selected');
    }
  }

  Future<void> _compressVideo(File video) async {
    final mediaInfo = await VideoCompress.compressVideo(
      video.path,
      quality: VideoQuality.MediumQuality,
      deleteOrigin: false,
    );

    if (mediaInfo != null) {
      setState(() {
        _compressedVideoFile = File(mediaInfo.file!.path);
      });
      print("Compressed video saved at: ${_compressedVideoFile!.path}");
      _playCompressedVideo();
    }
  }

  Future<void> _playCompressedVideo() async {
    if (_compressedVideoFile != null) {
      videoController = VideoPlayerController.file(_compressedVideoFile!)
        ..initialize().then((_) {
          setState(() {});
          videoController?.play();
        });
    }
  }

  @override
  void dispose() {
    super.dispose();
    videoController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'video Compress',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await _pickVideo(ImageSource.gallery);
              },
              child: Text('Pick a Video'),
            ),
            if (videoController != null && videoController!.value.isInitialized)
              Container(
                child: AspectRatio(
                  aspectRatio: videoController!.value.aspectRatio,
                  child: VideoPlayer(videoController!),
                ),
              ),
            if (videoController == null ||
                !videoController!.value.isInitialized)
              Text('No video selected or loading'),
          ],
        ),
      ),
    );
  }
}
