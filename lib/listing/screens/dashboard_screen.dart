import 'package:assignment/listing/screens/fetch_data_screen.dart';
import 'package:assignment/listing/screens/map_screen.dart';
import 'package:assignment/listing/screens/video_compressed_screen.dart';
import 'package:assignment/pagination/screens/pagination_screen.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'HomeScreen',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            ListTile(
              title: Text('Fetching Data'),
              onTap: () => fetchData(),
            ),
            ListTile(
              title: Text('Pagination'),
              onTap: () => PaginationScreen(),
            ),
            ListTile(
              title: Text('Map Screen'),
              onTap: () => MapScreen(),
            ),
            ListTile(
              title: Text('Location'),
              onTap: () => Location(),
            ),
            ListTile(
              title: Text('Video Compress'),
              onTap: () => VideoCompressedScreen(videoUrl: ''),
            ),
          ],
        ));
  }
}
