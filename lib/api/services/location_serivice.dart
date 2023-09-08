import 'dart:convert';

// import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';

import '../../secrets/secrets.dart';
import 'package:http/http.dart' as http;

class MapLocationService {
  Future<List<Prediction>?> placeAutoComplete(
      {required String placeInput}) async {
    try {
      Map<String, dynamic> querys = {
        'input': placeInput,
        'key': AppString.googleMapApiKey
      };
      final url = Uri.https(
          "maps.googleapis.com", "maps/api/place/autocomplete/json", querys);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<Prediction> predictionList = [];
        final predictions =
            jsonDecode(response.body)["predictions"] as List<dynamic>;
        for (var element in predictions) {
          predictionList.add(Prediction.fromJson(element));
        }
        return predictionList;
      } else {
        response.body;
      }
    } on Exception catch (e) {
    }
    return null;
  }

  Future<Map<String, dynamic>?> getPlaceCoordinate(String placeId) async {
    Map<String, dynamic> querys = {
      'place_id': placeId,
      'key': AppString.googleMapApiKey
    };

    final url =
        Uri.https("maps.googleapis.com", "maps/api/place/details/json", querys);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final bodyDecoded = jsonDecode(response.body);
        return bodyDecoded["result"]["geometry"]["location"];
      }
    } on Exception catch (e) {
      return null;
    }
    return null;
  }

  MapLocationService._sharedInstance();
  static final _shared = MapLocationService._sharedInstance();
  factory MapLocationService() => _shared;
}
