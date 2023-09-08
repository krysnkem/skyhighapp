import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';

class LocationProvider with ChangeNotifier {
  LocationPermission? _locationPermission;

  LocationPermission? get locationPermission => _locationPermission;

  //permission related logic
  Future<void> requestPermission() async {
    _locationPermission = await Geolocator.requestPermission();
    notifyListeners();
  }

  Future<void> openSettings() async {
    await Geolocator.openAppSettings();
    _locationPermission = await Geolocator.checkPermission();
    notifyListeners();
  }

  Future<void> onInitialization() async {
    _locationPermission = await Geolocator.checkPermission();
    notifyListeners();
  }

  LocationProvider() {
    onInitialization();
  }
}
