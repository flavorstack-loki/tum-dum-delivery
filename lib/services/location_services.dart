import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationServices {
  static const _location = Permission.location;

  static Future<bool> locationPermission() async {
    PermissionStatus? permissonStatus;
    bool serviceEnabled = await _location.isGranted;
    if (!serviceEnabled) {
      permissonStatus = await _location.request();
    } else {
      return true;
    }
    return permissonStatus == PermissionStatus.granted;
  }

  static Future<Position> getCurrentLocation() async =>
      await Geolocator.getCurrentPosition();
}
