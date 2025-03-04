import 'dart:async';

import 'package:assignment/models/lat_lng_models.dart';
import 'package:assignment/storage/location_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  final Location _location = Location();
  LatLng? _currentLatLng;
  List<LatLng> _polylineCoordinates = [];
  Set<Polyline> _polylines = {};
  late Timer _locationTimer;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  /// Request location permission and start tracking
  Future<void> _getCurrentLocation() async {
    var locationPermission = await _location.hasPermission();
    if (locationPermission == PermissionStatus.denied) {
      locationPermission = await _location.requestPermission();
    }

    if (locationPermission == PermissionStatus.granted) {
      LocationData? initialLocation = await _location.getLocation();
      if (initialLocation.latitude != null &&
          initialLocation.longitude != null) {
        _startTracking(
            LatLng(initialLocation.latitude!, initialLocation.longitude!));
      }

      _locationTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (_currentLatLng != null) {
          print(
              'Lat: ${_currentLatLng!.latitude}, Lng: ${_currentLatLng!.longitude}');
          _saveLocationData(_currentLatLng!);
        }
      });

      _location.onLocationChanged.listen((LocationData newLocation) {
        if (newLocation.latitude != null && newLocation.longitude != null) {
          _updatePosition(
              LatLng(newLocation.latitude!, newLocation.longitude!));
        }
      });
    } else {
      print("Location permission denied");
    }
  }

  /// Initialize the starting position
  void _startTracking(LatLng startPosition) {
    setState(() {
      _currentLatLng = startPosition;
      _polylineCoordinates.add(startPosition);
    });
  }

  /// Updates the route polyline as the user moves
  void _updatePosition(LatLng newLatLng) {
    setState(() {
      _currentLatLng = newLatLng;
      _polylineCoordinates.add(newLatLng);
      _updatePolylines();
    });

    if (_mapController != null && _currentLatLng != null) {
      _mapController!.animateCamera(CameraUpdate.newLatLng(_currentLatLng!));
    }
  }

  /// Generates polylines for tracking movement
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

  void _saveLocationData(LatLng latLng) async {
    DateTime now = DateTime.now();
    LocationPoint newLocation = LocationPoint(
      latitude: latLng.latitude,
      longitude: latLng.longitude,
      timestamp: now,
    );

    List<LocationPoint> storedLocations =
        await LocationStorage.fetchLocations();
    storedLocations.add(newLocation);
    await LocationStorage.saveLocation(storedLocations);
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Route Tracking',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: _currentLatLng != null
          ? GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _currentLatLng!,
                zoom: 15,
              ),
              polylines: _polylines,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
