import 'package:skyhighapp/utilities/capitalize.dart';

import '../entities/for_sky_api/order_data.dart';
import '../entities/for_sky_api/order_filter.dart';
import '../utilities/map_values.dart';

abstract class DataQuery {



  
  List<OrderData> filterDataBy({
    required List<OrderData> salesDataList,
    required OrderFilter filter,
  }) {
    assert(!(filter.month != null && filter.year == null),
        'Please specify a year');

    return salesDataList.where(
      (order) {
        if (filter.year == null) return true;
        return order.orderDate.endsWith(filter.year!);
      },
    ).where(
      (order) {
        if (filter.segment == null || filter.segment == Segment.all) {
          return true;
        }
        return order.segment == OrderMapValues.segementValues[filter.segment];
      },
    ).where(
      (order) {
        if (filter.region == null || filter.region == OrderRegion.all) {
          return true;
        }
        return order.region == filter.region!.name.capitalize();
      },
    ).where(
      (order) {
        if (filter.shipMode == null || filter.shipMode == ShipMode.all) {
          return true;
        }
        return order.shipMode ==
            OrderMapValues
                .segementValues[filter.shipMode]; // Filter by shipMode
      },
    ).where(
      (order) {
        if (filter.subCategory == null ||
            filter.subCategory == SubCategory.all) {
          return true;
        }
        return order.subCategory ==
            filter.subCategory!.name.capitalize(); // Filter by subCategory
      },
    ).where(
      (order) {
        if (filter.month == null || filter.month!.isEmpty) return true;
        final date = order.orderDate.split('/');

        return date[0] == filter.month;
      },
    ).where(
      (order) {
        if (filter.city == null || filter.city!.isEmpty) return true;
        return order.city == filter.city; // Filter by city
      },
    ).toList();
  }
}
