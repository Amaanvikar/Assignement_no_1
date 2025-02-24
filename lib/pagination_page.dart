// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class _PaginationPagState extends StatefulWidget {
//   const _PaginationPagState({super.key});

//   @override
//   State<_PaginationPagState> createState() => __PaginationPagStateState();
// }

// class __PaginationPagStateState extends State<_PaginationPagState> {
//   List posts = [];
//   @override
//   void initState() {
//     super.initState();
//     fetchPost();
//   }

//   Future<void> fetchPost() async {
//     var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');

//     try {
//       var response = await http.get(url);
//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body) as List;
//         setState(() {
//           posts = json;
//         });
//         print('Response Data: $json');
//       } else {
//         print('Response failed with status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('FetchPost'),
//       ),
//       body: ListView.builder(
//         itemCount: posts.length,
//         itemBuilder: (context, index) {
//           final id = posts[index];
//           final title = post['title'];
//           final body = post['body'];
//           return ListTile(
//             title: Text('$title'),
//             subtitle: Text('$body'),
//           );
//         },
//       ),
//     );
//   }
// }

// import 'package:assignment/widgets/constant.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';

// class GoogleMapPolyLines extends StatefulWidget {
//   const GoogleMapPolyLines({super.key});

//   @override
//   State<GoogleMapPolyLines> createState() => _GoogleMapPolyLinesState();
// }

// class _GoogleMapPolyLinesState extends State<GoogleMapPolyLines> {
//   final locationController = Location();


//   static const _googlePlex = LatLng(19.0760, 72.8777);
//   static const _mountainView = LatLng(12.9716, 77.5946);

//     LatLng? currentPosition;


//   Map<PolylineId, Polyline> polylines = {};

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance
//     .addPostFrameCallback((_) async => fetchLocationupadate());
//   }

//   Future<List<LatLng>> fetchPolylinesPoints() async {
//     final polylinePoints = PolylinePoints();

//     final result = await polylinePoints.getRouteBetweenCoordinates(
//       googleMapsApiKey,
//       PointLatLng(_googlePlex.latitude, _googlePlex.longitude),
//       PointLatLng(_mountainView.latitude, _mountainView.longitude),
//     );

//     if (result.points.isNotEmpty) {
//       return result.points
//           .map((point) => LatLng(point.latitude, point.longitude))
//           .toList();
//     } else {
//       print(result.errorMessage);
//       return [];
//     }
//   }

//   Future<void> getPolyLinesFromPoints(List<LatLng> _polylineCoordinates) async {
//     const id = PolylineId('polylines');

//     final polyline = Polyline(
//       polylineId: id,
//       color: Colors.blueAccent,
//       points: _polylineCoordinates,
//       width: 5,
//     );

//     setState(() {
//       polylines[id] = polyline;
//     });
//   }

//   Future<void> initializeMap() async {
//     await fetchPolylinesPoints();
//     final coordinates = await fetchPolylinesPoints();
//   }

//   Future<void> fetchLocationupadate() async {
//     bool serviceEnabled;
//     PermissionStatus permissionGranted;

//     ServiceEnabled = await locationController.serviceEnabled();
//     if (serviceEnabled) {
//       serviceEnabled = await locationController.requestService();
//     } else {
//       return;
//     }


//     permissionGranted = await locationController.hasPermission();
//     if (permissionGranted == PermissionStatus.denied) {
//       permissionGranted = await locationController.requestPermission();
//       if (LocationPermission != PermissionStatus.granted) {
//         return;
//       }
//     }

//     locationController.onLocationChanged.listen((CurrentLocation){
//       if(CurrentLocation.latitude != null &&
//       CurrentLocation.longitude != null){
//         setState(() {
//           currentPosition =LatLng (
//             CurrentLocation.latitude!,
//             CurrentLocation.longitude!,
//           );
//         });
//         print(currentPosition!);
//       }
//     });
//     }
//   }



//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('polyLines'),
//       ),
//       body: GoogleMap(
//         initialCameraPosition: CameraPosition(
//           target: _googlePlex,
//           zoom: 13,
//         ),
//         markers: {
//           Marker(
//             markerId: MarkerId('sourceLocation'),
//             icon: BitmapDescriptor.defaultMarker,
//             position: _googlePlex,
//           ),
//           Marker(
//             markerId: MarkerId('destinationlocation'),
//             icon: BitmapDescriptor.defaultMarker,
//             position: _mountainView,
//           ),
//         },
//         polylines: Set<Polyline>.of(polylines.values),
//       ),
//     );
//   }
// }
