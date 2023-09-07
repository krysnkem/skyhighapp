import '../model/order_data_model.dart';

abstract class DataApiService {
  Future<List<OrderDataModel>> getSalesDataList();
}
