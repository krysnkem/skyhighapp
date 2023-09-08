import 'package:skyhighapp/entities/for_sky_api/order_data.dart';
import 'package:skyhighapp/entities/for_sky_api/order_filter.dart';
import 'package:skyhighapp/queries/kpi/kpi_query.dart';

class ProfitQuery extends KpiQuery {
  @override
  double forTheMonth({
    required List<OrderData> salesDataList,
    required String year,
    required String month,
    OrderFilter? filter,
  }) {
    (!(filter != null && filter.month != null));

    final newFilter = filter?.copyWith(year: year, month: month) ??
        OrderFilter(year: year, month: month);
    final ordersForTheMonth =
        filterDataBy(filter: newFilter, salesDataList: salesDataList);
    double profitForTheMonth = 0.0;
    for (final order in ordersForTheMonth) {
      profitForTheMonth += order.profit;
    }
    return profitForTheMonth;
  }

  @override
  double getRegion({
    required List<OrderData> salesDataList,
    required OrderFilter filter,
  }) {
    double regionSales = 0.0;
    final allRegionSales =
        filterDataBy(salesDataList: salesDataList, filter: filter);
    for (final order in allRegionSales) {
      if (order.profit > 0) {
        regionSales += order.profit;
      }
    }
    return regionSales;
  }

  @override
  double totalForTheYear({
    required String year,
    required List<OrderData> salesDataList,
    OrderFilter? filter,
  }) {
    salesDataList = filterDataBy(
      salesDataList: salesDataList,
      filter: filter?.copyWith(year: year) ?? OrderFilter(year: year),
    );
    double total = 0.0;
    for (final data in salesDataList) {
      if (data.profit > 0) {
        total += data.profit;
      }
    }

    return total;
  }
}
