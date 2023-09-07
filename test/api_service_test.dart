import 'package:skyhighapp/api/model/order_data_model.dart';
import 'package:skyhighapp/api/services/data_api_service.dart';
import 'package:skyhighapp/entities/for_sky_api/order_data.dart';
import 'package:skyhighapp/entities/for_sky_api/order_filter.dart';
import 'package:skyhighapp/queries/kpi/profit_query.dart';
import 'package:skyhighapp/repository/sales_data_repository.dart';
import 'package:skyhighapp/utilities/parse_json.dart';

import 'fixture_reader.dart';

void main() async {
  testProfitQueryWithFilteredTotal();
}

void otherTests() {
  // final dataSet = await ApiService().getSalesDataList();
  // DataQuery.dataStore.addAll(dataSet);
  // print('Total sale:${DataQuery.totalSales}');
  // print('Total profit:${DataQuery.totalProfit}');
  // print('Total quantity:${DataQuery.totalQuantityOfItemsSoled}');
  // print('Tolal sales in 2017 $')

  final repository = SalesDataRepository(FakeApiService());

  final filteredSales = repository.getListOfSalesForEachMonthOfYear(
      year: '2016', filter: OrderFilter(region: OrderRegion.central));
  print(filteredSales);
  // print('sales');
  // print(filteredSales);
  // print('Total Sales');
  // print(await repository.getListOfSalesForEachMonthOfYear(year: '2017'));
}

class FakeApiService implements DataApiService {
  FakeApiService();
  final body = fixture('response.json');
  @override
  Future<List<OrderDataModel>> getSalesDataList() async {
    final decoded = pareseResponseBody(body);
    return Future.value(decoded);
  }
}

void testProfitQuery() {
  final profitQuery = ProfitQuery();
  print(profitQuery.getListofSumForTheYear(
    salesDataList: salesDataList,
    year: "2016",
    filter: OrderFilter(region: OrderRegion.west),
  ));
}

void testProfitQueryWithRegion() {
  final profitQuery = ProfitQuery();
  print(
    profitQuery.getDataforAllRegions(
      salesDataList: salesDataList,
      year: '2017',
      filter: OrderFilter(
        region: OrderRegion.east,
        year: "2016",
      ),
    ),
  );
}

void testProfitQueryWithFilteredTotal() {
  final profitQuery = ProfitQuery();
  print(
    profitQuery.totalForTheYear(
      year: '2016',
      salesDataList: salesDataList,
      filter: OrderFilter(
        region: OrderRegion.west,
      ),
    ),
  );
}

final salesDataList = [
  OrderData(
    orderId: "orderId",
    profit: 1,
    city: "city",
    customerName: "customerName",
    productName: "productName",
    rowId: "rowId",
    country: "country",
    discount: 1,
    customerId: "customerId",
    region: "West",
    quantity: 2,
    segment: "segment",
    state: "state",
    shipMode: "shipMode",
    subCategory: "subCategory",
    postalCode: "postalCode",
    shipDate: "shipDate",
    category: "category",
    productId: "productId",
    sales: 1,
    orderDate: "5/30/2016",
  ),
  OrderData(
    orderId: "orderId",
    profit: 1,
    city: "city",
    customerName: "customerName",
    productName: "productName",
    rowId: "rowId",
    country: "country",
    discount: 1,
    customerId: "customerId",
    region: "South",
    quantity: 2,
    segment: "segment",
    state: "state",
    shipMode: "shipMode",
    subCategory: "subCategory",
    postalCode: "postalCode",
    shipDate: "shipDate",
    category: "category",
    productId: "productId",
    sales: 1,
    orderDate: "5/30/2016",
  ),
  OrderData(
    orderId: "orderId",
    profit: 1,
    city: "city",
    customerName: "customerName",
    productName: "productName",
    rowId: "rowId",
    country: "country",
    discount: 1,
    customerId: "customerId",
    region: "South",
    quantity: 2,
    segment: "segment",
    state: "state",
    shipMode: "shipMode",
    subCategory: "subCategory",
    postalCode: "postalCode",
    shipDate: "shipDate",
    category: "category",
    productId: "productId",
    sales: 1,
    orderDate: "5/30/2016",
  ),
  OrderData(
    orderId: "orderId",
    profit: 1,
    city: "city",
    customerName: "customerName",
    productName: "productName",
    rowId: "rowId",
    country: "country",
    discount: 1,
    customerId: "customerId",
    region: "West",
    quantity: 2,
    segment: "segment",
    state: "state",
    shipMode: "shipMode",
    subCategory: "subCategory",
    postalCode: "postalCode",
    shipDate: "shipDate",
    category: "category",
    productId: "productId",
    sales: 1,
    orderDate: "5/30/2016",
  ),
];
