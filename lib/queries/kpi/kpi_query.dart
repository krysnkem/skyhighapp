import 'package:skyhighapp/queries/data_query.dart';

import '../../entities/for_sky_api/order_data.dart';
import '../../entities/for_sky_api/order_filter.dart';

abstract class KpiQuery extends DataQuery {
  List<double> getListofSumForTheYear({
    required List<OrderData> salesDataList,
    required String year,
    OrderFilter? filter,
  }) {
    assert(!(filter != null && filter.year != null && filter.year != year));

    List<double> listforTheYear = [];
    for (int i = 0; i < 12; i++) {
      double fortheMonth = forTheMonth(
        salesDataList: salesDataList,
        year: year,
        month: (1 + i).toString(),
        filter: filter,
      );
      fortheMonth = double.parse(fortheMonth.toStringAsFixed(2));
      listforTheYear.add(fortheMonth);
    }
    return listforTheYear;
  }

  double forTheMonth({
    required List<OrderData> salesDataList,
    required String year,
    required String month,
    OrderFilter? filter,
  });

  double getRegion({
    required List<OrderData> salesDataList,
    required OrderFilter filter,
  });
  Map<OrderRegion, double> getDataforAllRegions({
    required List<OrderData> salesDataList,
    required String year,
    OrderFilter? filter,
  }) {
    Map<OrderRegion, double> regionData = {};
    for (final region in OrderRegion.values) {
      regionData[region] = getRegion(
        salesDataList: salesDataList,
        filter: filter?.copyWith(year: year, region: region) ??
            OrderFilter(year: year, region: region),
      );
    }
    return regionData;
  }

  double totalForTheYear({required String year, required List<OrderData> salesDataList,  OrderFilter? filter});
}
