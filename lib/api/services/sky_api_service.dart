import 'dart:convert';

// import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:skyhighapp/api/exception/exceptions.dart';
import 'package:skyhighapp/api/model/order_data_model.dart';
import 'package:skyhighapp/api/services/data_api_service.dart';

import '../../utilities/parse_json.dart';

class SkyApiService implements DataApiService {
  final String apiRoute =
      'https://g54qw205uk.execute-api.eu-west-1.amazonaws.com/DEV/stub';

  @override
  Future<List<OrderDataModel>> getSalesDataList() async {
    try {
      final response = await http.post(Uri.parse(apiRoute),
          body: jsonEncode({"angular_test": "angular-developer"}));
      if (response.statusCode != 200) {
        throw UnableToGetDataException();
      }
      final body = response.body;
      // return compute(pareseResponseBody, body);
      return pareseResponseBody(body);
    } on Exception catch (e) {
      throw UnableToGetDataException();
    }
  }

  SkyApiService._sharedInstance();
  static final _shared = SkyApiService._sharedInstance();
  factory SkyApiService() {
    return _shared;
  }
}
