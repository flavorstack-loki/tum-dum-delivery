import 'package:location/location.dart';

class LocationServices {
  static final Location _location = Location();
  static Future<bool> locationPermission() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
    }

    PermissionStatus permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
    }
    return serviceEnabled && permissionGranted == PermissionStatus.granted;
  }
}
