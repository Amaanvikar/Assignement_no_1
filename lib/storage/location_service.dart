// // import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
// //     as bg;

// class LocationService {
//   void init() {
//     bg.BackgroundGeolocation.onLocation((bg.Location location) {
//       print(
//           'Lat: ${location.coords.latitude}, Lng: ${location.coords.longitude}');
//     });

//     bg.BackgroundGeolocation.ready(bg.Config(
//       distanceFilter: 10, // Minimum distance (meters) between location updates
//       desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
//       stopOnTerminate: false, // Keep tracking in background
//       startOnBoot: true, // Start tracking after reboot
//     )).then((bg.State state) {
//       bg.BackgroundGeolocation.start();
//     });
//   }
// }
