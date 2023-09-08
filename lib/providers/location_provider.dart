import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:skyhighapp/api/services/location_serivice.dart';

class LocationProvider with ChangeNotifier {
  late final LocationService _locationService;
  late GoogleMapController _mapController;

  Position? _currentPosition;
  LatLng _currentLatLng = const LatLng(27.671332124757402, 85.3125417636781);
  Marker? marker;

  LocationPermission? _locationPermission;

  String locationText = '';

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

  //map related logic
  void setMarker() {
    marker = Marker(
        markerId: const MarkerId("1"),
        // icon: currentLocation!,
        position: _currentLatLng);
  }

  Future<void> setLocationToCurrentUserLocation() async {
    _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _currentLatLng = LatLng(
      _currentPosition!.latitude,
      _currentPosition!.longitude,
    );

    setMarker();
  }

  void setMapController(GoogleMapController controller) async {
    _mapController = controller;
    String val = "json/google_map_dark_light.json";
    var mapStyle = await rootBundle.loadString(val);
    _mapController.setMapStyle(mapStyle);
    notifyListeners();
  }

  Future<void> changeLocation(Prediction description) async {
    final result =
        await _locationService.getPlaceCoordinate(description.placeId!);
    final latLong = LatLng.fromJson(result)!;
    _currentLatLng = latLong;
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: latLong, zoom: 15),
      ),
    );
    setMarker();
    notifyListeners();
  }

  Future<List<Prediction>?> getListOfPredictions({required String text}) {
    return _locationService.placeAutoComplete(placeInput: text);
  }

  void onSuggestionSelected(Prediction? suggestion) async {
    locationText = suggestion?.structuredFormatting?.mainText ?? "";
    if (suggestion != null) {
      await changeLocation(suggestion);
    }
    notifyListeners();
  }

  Future<void> onInitialization() async {
    _locationPermission = await Geolocator.checkPermission();
    if (_locationPermission == LocationPermission.always ||
        _locationPermission == LocationPermission.whileInUse) {
      setMarker();
      await setLocationToCurrentUserLocation();
    }
    notifyListeners();
  }

  LocationProvider(LocationService locationService)
      : _locationService = locationService {
    onInitialization();
  }
}
