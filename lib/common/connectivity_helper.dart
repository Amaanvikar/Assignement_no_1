import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityHelper {
  // Method to check if the device is connected to the internet
  static Future<bool> isConnected() async {
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();

    // Check for WiFi or mobile data connection
    if (ConnectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      print('No internet connecttion');
      return false;
    }
  }
}
