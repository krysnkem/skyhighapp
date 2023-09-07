import 'dart:convert';

import '../api/model/order_data_model.dart';

List<OrderDataModel> pareseResponseBody(String body) {
  final jsonDecoded = jsonDecode(body) as List<dynamic>;
  return jsonDecoded
      .map<OrderDataModel>((data) => OrderDataModel.fromJson(data))
      .toList();
}