import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;
  final Location _location = Location();

  LatLng? _currentLatLng;
  LocationData? _currentLocation;

  final List<LatLng> predefinedLocations = [
    LatLng(9.9975, 73.7898),
    LatLng(19.0760, 72.8777),
    LatLng(12.9716, 77.5946),
  ];

  List<Marker> _markers = [];
  Set<Circle> _circles = {};
  Set<Polyline> _polylines = {};
  List<LatLng> _polylineCoordinates = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    var locationPermission = await _location.hasPermission();
    if (locationPermission == PermissionStatus.denied) {
      locationPermission = await _location.requestPermission();
    }

    if (locationPermission == PermissionStatus.granted) {
      _currentLocation = await _location.getLocation();
      _updatePosition(_currentLocation!);

      _location.onLocationChanged.listen((LocationData newLocation) {
        _updatePosition(newLocation);
      });
    } else {
      print("Location permission denied");
    }
  }

  void _updatePosition(LocationData locationData) {
    if (locationData.latitude != null && locationData.longitude != null) {
      LatLng newLatLng =
          LatLng(locationData.latitude!, locationData.longitude!);

      setState(() {
        _currentLatLng = newLatLng;
        _polylineCoordinates.add(newLatLng);
        _updatePolylines();
      });

      if (_mapController != null) {
        _mapController.animateCamera(CameraUpdate.newLatLng(_currentLatLng!));
      }
    }
  }

  void _updatePolylines() {
    setState(() {
      _polylines.clear();
      _polylines.add(
        Polyline(
          polylineId: PolylineId("user_route"),
          color: Colors.blue,
          width: 5,
          points: _polylineCoordinates,
        ),
      );
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;

    setState(() {
      _markers = predefinedLocations.map((latLng) {
        return Marker(
          markerId: MarkerId(latLng.toString()),
          position: latLng,
          infoWindow: InfoWindow(
            title: "Marker at (${latLng.latitude}, ${latLng.longitude})",
            snippet: "Lat: ${latLng.latitude}, Lng: ${latLng.longitude}",
          ),
        );
      }).toList();

      _circles = predefinedLocations.map((latLng) {
        return Circle(
          circleId: CircleId(latLng.toString()),
          center: latLng,
          radius: 5000,
          strokeWidth: 2,
          strokeColor: Colors.blue,
          fillColor: Colors.blue.withOpacity(0.2),
        );
      }).toSet();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Google Maps (Live Tracking)',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: _currentLatLng != null
          ? GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: predefinedLocations.isNotEmpty
                    ? predefinedLocations[0]
                    : LatLng(9.9975, 73.7898),
                // target: _currentLatLng ?? LatLng(9.9975, 73.7898),
                zoom: 13,
              ),
              markers: Set<Marker>.of(_markers),
              circles: _circles,
              polylines: _polylines,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
