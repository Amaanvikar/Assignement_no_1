import 'dart:convert';
import 'package:assignment/models/lat_lng_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationStorage {
  // Save the location data to SharedPreferences
  static Future<void> saveLocation(List<LocationPoint> points) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> pointsJson = points
        .map((point) => jsonEncode({
              'latitude': point.latitude,
              'longitude': point.longitude,
              'timestamp': point.timestamp.toIso8601String(),
            }))
        .toList();
    await prefs.setStringList('locations', pointsJson);
  }

  // Fetch the location data from SharedPreferences
  static Future<List<LocationPoint>> fetchLocations() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? pointsJson = prefs.getStringList('locations');
    if (pointsJson != null) {
      return pointsJson
          .map((point) => LocationPoint(
                latitude: jsonDecode(point)['latitude'],
                longitude: jsonDecode(point)['longitude'],
                timestamp: DateTime.parse(jsonDecode(point)['timestamp']),
              ))
          .toList();
    }
    return [];
  }
}
