import '../api/model/order_data_model.dart';
import '../api/services/data_api_service.dart';
import '../utilities/parse_json.dart';
import 'fixture_reader.dart';

class FakeApiService implements DataApiService {
  FakeApiService();
  @override
  Future<List<OrderDataModel>> getSalesDataList() async {
    final body = await fixture('response.json');

    final decoded = pareseResponseBody(body);
    return Future.value(decoded);
  }
}
