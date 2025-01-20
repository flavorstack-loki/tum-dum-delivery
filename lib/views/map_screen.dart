import 'dart:async';
import 'package:animated_marker/animated_marker.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  final Completer<GoogleMapController> _controller = Completer();

  final Location _location = Location();

  final LatLng _agentLocation = const LatLng(
    18.850604,
    82.575908,
  );
  final LatLng _customerLocation = const LatLng(18.853088, 82.576934);
  Marker? _agentMarker;
  Marker? _customerMarker;
  Polyline _routePolyline = const Polyline(
      polylineId: PolylineId("route"), width: 5, color: Colors.blue);
  // List<LatLng> _routeCoordinates = [];
  // StreamSubscription<LocationData>? _locationSubscription;

  late AnimationController _markerAnimationController;
  // late Animation<LatLng> _markerAnimation;

  @override
  void initState() {
    super.initState();
    _initializeMarkers();
    _trackLocation();
  }

  void _initializeMarkers() {
    _customerMarker = Marker(
      markerId: const MarkerId("customer"),
      position: _customerLocation,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );
  }

  // final GoogleMapsServices mapsHelper = GoogleMapsServices(googleMapsApiKey);

  void _trackLocation() async {
    // bool _serviceEnabled = await _location.serviceEnabled();
    // if (!_serviceEnabled) {
    //   _serviceEnabled = await _location.requestService();
    // }

    // PermissionStatus _permissionGranted = await _location.hasPermission();
    // if (_permissionGranted == PermissionStatus.denied) {
    //   _permissionGranted = await _location.requestPermission();
    // }
    // final location = await _location.getLocation();

    // _locationSubscription =
    //     _location.onLocationChanged.listen((LocationData locationData) async {
    // LatLng rawLocation = LatLng(location.latitude!, location.longitude!);

    // Snap to nearest road
    // LatLng snappedLocation = await mapsHelper.getSnappedLocation(rawLocation);

    // Fetch the route to the customer
    // List<LatLng> route =
    //     await mapsHelper.getRoute(_agentLocation, _customerLocation);
    setState(() {
      //  _agentLocation = LatLng(location.latitude!, location.longitude!);
      _routePolyline = const Polyline(
        polylineId: PolylineId("route"),
        //    points: route,
        color: Colors.blue,
        width: 5,
      );
    });

    // Update polyline and animate marker
    //   _animateMarkerAlongRoute(route);
    //   });
  }

  void _animateMarkerAlongRoute(List<LatLng> route) async {
    for (int i = 0; i < route.length; i++) {
      await Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _agentMarker = Marker(
            markerId: const MarkerId("agent"),
            position: route[i],
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          );
          _routePolyline = Polyline(
            polylineId: const PolylineId("route"),
            points: route.sublist(i),
            color: Colors.blue,
            width: 5,
          );
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery Tracking'),
        backgroundColor: Colors.blueAccent,
      ),
      body: _agentLocation == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                AnimatedMarker(
                    staticMarkers: {
                      if (_customerMarker != null) _customerMarker!,
                    },
                    animatedMarkers: {
                      if (_agentMarker != null) _agentMarker!,
                    },
                    duration: const Duration(
                        seconds: 3), // change the animation duration
                    fps: 30, // change the animation frames per second
                    curve: Curves.easeOut, // change the animation curve
                    builder: (context, animatedMarkers) => GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: _agentLocation,
                            zoom: 14.0,
                          ),
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                          },
                          markers: animatedMarkers,
                          polylines: {_routePolyline},
                          myLocationEnabled: true,
                        )),
                Positioned(
                  top: 20,
                  left: 20,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 10)
                      ],
                    ),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Delivery in progress",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        Text("Agent is moving towards the customer location."),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  // @override
  // void dispose() {
  //   _locationSubscription?.cancel();
  //   _markerAnimationController.dispose();
  //   super.dispose();
  // }
}
