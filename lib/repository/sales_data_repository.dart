import 'package:skyhighapp/api/services/data_api_service.dart';
import 'package:skyhighapp/entities/for_sky_api/order_data.dart';
import 'package:skyhighapp/queries/kpi/profit_query.dart';
import 'package:skyhighapp/queries/kpi/sales_query.dart';

import '../entities/for_sky_api/order_filter.dart';

class SalesDataRepository {
  final DataApiService _apiService;
  final ProfitQuery profitQuery = ProfitQuery();
  final SalesQuery salesQuery = SalesQuery();

  SalesDataRepository(this._apiService);

  final List<OrderData> _salesDataList = [];

  Future<List<OrderData>> get getAllSalesData async {
    final dataSet = await _apiService.getSalesDataList();
    _salesDataList.addAll(dataSet);
    return dataSet;
  }

  List<double> getListOfSalesForEachMonthOfYear({
    required String year,
    OrderFilter? filter,
  }) {
    return salesQuery.getListofSumForTheYear(
      salesDataList: _salesDataList,
      year: year,
      filter: filter,
    );
  }

  Map<OrderRegion, double> getDetailsOfProfitForEachRegion({
    required String year,
    OrderFilter? filter,
  }) {
    return profitQuery.getDataforAllRegions(
        salesDataList: _salesDataList, year: year, filter: filter);
  }

  Map<OrderRegion, double> getDetailsOfSalesForEachRegion({
    required String year,
    OrderFilter? filter,
  }) {
    return salesQuery.getDataforAllRegions(
        salesDataList: _salesDataList, year: year, filter: filter);
  }

  /// get a list of sum of profits for each month
  List<double> getListOfProfitsForEachMonthOfYear({
    required String year,
    OrderFilter? filter,
  }) {
    return profitQuery.getListofSumForTheYear(
      salesDataList: _salesDataList,
      year: year,
      filter: filter,
    );
  }

  List<OrderRegion> get regionValues {
    return OrderRegion.values;
  }

  List<Segment> get segmentValues {
    return Segment.values;
  }

  List<SubCategory> get subCategoryValues {
    return SubCategory.values;
  }

  List<String> get years {
    return [
      "2014",
      "2015",
      "2016",
      "2017",
    ];
  }

  double totalSalesForTheYear(String year) {
    return salesQuery.totalForTheYear(
      year: year,
      salesDataList: _salesDataList,
    );
  }

  double totalProfitForTheYear(String year) {
    return profitQuery.totalForTheYear(
      year: year,
      salesDataList: _salesDataList,
    );
  }

  double totalFilteredSalesForTheYear({
    required String year,
    required OrderFilter filter,
  }) {
    return salesQuery.totalForTheYear(
      year: year,
      salesDataList: _salesDataList,
      filter: filter,
    );
  }

  double totalFilteredProfitForTheYear({
    required String year,
    required OrderFilter filter,
  }) {
    return profitQuery.totalForTheYear(
      year: year,
      salesDataList: _salesDataList,
      filter: filter,
    );
  }

  double get totalProfit {
    double total = 0.0;
    for (final data in _salesDataList) {
      total += data.profit;
    }
    return total;
  }

  double get totalQuantityOfItemsSoled {
    double total = 0.0;
    for (final data in _salesDataList) {
      total += data.quantity;
    }
    return total;
  }
}
