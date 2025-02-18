import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:assignment/models/db_helper.dart';
import 'package:assignment/models/service_request_models.dart';

class DetailsPage extends StatefulWidget {
  final ServiceRequest data;
  const DetailsPage({Key? key, required this.data}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  String? _imagePath;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadStoredImage();
    print(widget.data.toMap()); // Debugging output
  }

  Future<void> _loadStoredImage() async {
    final databaseService = DatabaseService.instance;

    final storedRequest = await databaseService
        .getServiceRequestByBookingReference(widget.data.bookingReferenceNo);

    print("Fetched from DB: ${storedRequest?.imagePath}");

    if (storedRequest != null && storedRequest.imagePath != null) {
      setState(() {
        _imagePath = storedRequest.imagePath;
      });
    }
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);

      if (pickedFile != null) {
        String savedPath = await _saveImageToLocalStorage(pickedFile.path);

        setState(() {
          _imagePath = savedPath;
        });
        print("Picked Image Path: $_imagePath");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to pick image: $e")),
      );
    }
  }

  Future<String> _saveImageToLocalStorage(String imagePath) async {
    final Directory directory = await getApplicationDocumentsDirectory();

    final DateTime now = DateTime.now();
    final String timestamp = now.millisecondsSinceEpoch.toString();

    // final String newPath =
    //     '${directory.path}/${widget.data.bookingReferenceNo}_image.jpg';

    final String newPath = '${directory.path}/$timestamp.jpg';

    await File(imagePath).copy(newPath);
    print("Image saved at: $newPath");
    return newPath;
  }

  Future<void> _submitImage() async {
    if (_imagePath != null) {
      final databaseService = DatabaseService.instance;

      widget.data.imagePath = _imagePath;
      await databaseService.insertImagePath(
        bookingReferenceNo: widget.data.bookingReferenceNo,
        imagePath: _imagePath!,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Image updated successfully!")),
      );
    }
  }

  void _showImagePickerDialog() {
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
                  pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.image, color: Colors.green),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.gallery);
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
      appBar: AppBar(title: const Text("Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Booking Ref: ${widget.data.bookingReferenceNo}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text("Complaint: ${widget.data.complaintDescription}"),
            Text("Requested Date: ${widget.data.requestedDate}"),
            Text("Planned Start: ${widget.data.plannedStartDate}"),
            Text("Location: ${widget.data.siteAddress}"),
            Text("Engineer: ${widget.data.sREngineerName}"),
            Text("Customer Contact: ${widget.data.custContactNo}"),
            const SizedBox(height: 20),
            _imagePath != null && _imagePath!.isNotEmpty
                ? Card(
                    elevation: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Image.file(File(_imagePath!), fit: BoxFit.cover),
                  )
                : ElevatedButton.icon(
                    onPressed: _showImagePickerDialog,
                    icon: const Icon(Icons.add_a_photo),
                    label: const Text('Add Image'),
                  ),
            if (_imagePath != null)
              ElevatedButton(
                onPressed: _submitImage,
                child: const Text('Submit Image'),
              ),
          ],
        ),
      ),
    );
  }
}
