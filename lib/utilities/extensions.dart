import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';

extension ToString on Prediction {
  String customToString() {
    return 'Prediction($description, $placeId)';
  }
}
