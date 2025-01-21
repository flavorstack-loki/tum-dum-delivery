import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

class LocationServices {
  static final Location _location = Location();
  static Future<bool> locationPermission() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
    }
    PermissionStatus permission = await _location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await _location.requestPermission();
    }
    if (permission == PermissionStatus.deniedForever) {
      await ph.openAppSettings();
    }

    return serviceEnabled &&
        permission != PermissionStatus.denied &&
        permission != PermissionStatus.deniedForever;
  }

  static Future<LocationData> getCurrentLocation() async =>
      await _location.getLocation();
}
