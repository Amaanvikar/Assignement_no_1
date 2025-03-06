import 'package:assignment/auth/login_page.dart';
import 'package:assignment/listing/screens/camera_screen.dart';
import 'package:assignment/listing/screens/map_screen.dart';
import 'package:assignment/listing/screens/submit_form_page.dart';
import 'package:assignment/listing/screens/video_compressed_screen.dart';
import 'package:assignment/models/service_request_models.dart';
import 'package:assignment/pagination/screens/pagination_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerWidget extends StatefulWidget {
  final ServiceRequest? item;
  const DrawerWidget({super.key, this.item});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  String? userName;
  String? userEmail;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? "Guest";
      userEmail = prefs.getString('userEmail') ?? "user@example.com";
    });
  }

  void logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              widget.item != null
                  ? "User Name: ${widget.item!.customerName}"
                  : "User Name: Guest",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            accountEmail: const Text("user@example.com"),
          ),
          ListTile(
              leading: const Icon(Icons.pageview_outlined),
              title: Text('Pagination'),
              onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaginationScreen(),
                    ),
                  )),
          ListTile(
            leading: const Icon(Icons.location_on_outlined),
            title: Text(
              'Location',
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MapScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.video_settings_rounded),
            title: Text('Video Compress'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VideoCompressedScreen(
                            videoUrl: '',
                          )));
            },
          ),
          ListTile(
              leading: const Icon(Icons.photo_camera_outlined),
              title: Text('Camera Screen'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CameraScreen()));
              }),
          ListTile(
              leading: const Icon(
                  Icons.signal_wifi_statusbar_connected_no_internet_4_outlined),
              title: Text('Check Connectivity'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SubmitFormPage()));
              }),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout"),
            onTap: () => logout(context),
          ),
        ],
      ),
    );
  }
}
