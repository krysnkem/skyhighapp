import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:skyhighapp/api/services/location_serivice.dart';

class MapProvider with ChangeNotifier {
  late GoogleMapController _mapController;

  late final MapLocationService _locationService;

  Position? _currentPosition;
  LatLng _currentLatLng = const LatLng(27.671332124757402, 85.3125417636781);

  LatLng get currentLatLng => _currentLatLng;

  late CameraPosition initialPosition =
      CameraPosition(target: _currentLatLng, zoom: 16);

  Marker? marker;

  String locationText = '';

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
  }

  void setMapController(GoogleMapController controller) async {
    _mapController = controller;
    // String val = "json/google_map_light_theme.json";
    // var mapStyle = await rootBundle.loadString(val);
    // _mapController.setMapStyle(mapStyle);
    notifyListeners();
    controller.animateCamera(CameraUpdate.newLatLng(_currentLatLng));
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
    await setLocationToCurrentUserLocation();
    notifyListeners();
  }

  MapProvider(MapLocationService locationService)
      : _locationService = locationService {
    onInitialization();
  }
}
