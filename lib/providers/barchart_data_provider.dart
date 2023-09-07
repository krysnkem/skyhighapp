import 'package:flutter/material.dart';

import '../entities/for_sky_api/order_data.dart';
import '../entities/for_sky_api/order_filter.dart';
import '../repository/sales_data_repository.dart';

class BarChartDataProvider extends ChangeNotifier {
  late Future<List<OrderData>> allSalesData;
  late List<double> saleDataList;
  late List<double> profiltDataList;
  late SalesDataRepository repository;

  OrderRegion barRegionValue = OrderRegion.all;
  SubCategory barSubCategoryValue = SubCategory.all;
  Segment barSegmentValue = Segment.all;
  OrderFilter barFilter = OrderFilter();

  String year = "2014";

  String get getTotalSales {
    var totalSales = repository.totalSalesForTheYear(year);

    return parseAmount(totalSales);
  }

  String get getTotalProfit {
    var totalProfit = repository.totalProfitForTheYear(year);
    print('Unfilterd total profit $totalProfit');
    return parseAmount(totalProfit);
  }

  String parseAmount(double amount) {
    if (amount >= 1000 && amount < 1000000) {
      amount = amount / 1000;
      return "${amount.toStringAsFixed(2)}K";
    } else if (amount > 1000000) {
      amount = amount / 1000000;
      return "${amount.toStringAsFixed(2)}M";
    } else {
      return amount.toStringAsFixed(2);
    }
  }

  void onChanged(value) {
    barRegionValue = value!;
    barFilter = barFilter.copyWith(region: value);
    saleDataList = repository.getListOfSalesForEachMonthOfYear(
      year: year,
      filter: barFilter,
    );
    profiltDataList = repository.getListOfProfitsForEachMonthOfYear(
      year: year,
      filter: barFilter,
    );

    notifyListeners();
  }

  void onChangedSegment(value) {
    barSegmentValue = value!;
    barFilter = barFilter.copyWith(segment: value);
    saleDataList = repository.getListOfSalesForEachMonthOfYear(
      year: year,
      filter: barFilter,
    );
    profiltDataList = repository.getListOfProfitsForEachMonthOfYear(
      year: year,
      filter: barFilter,
    );
    notifyListeners();
  }

  void onChangedSubcategory(value) {
    barSubCategoryValue = value!;
    barFilter = barFilter.copyWith(subCategory: value);
    saleDataList = repository.getListOfSalesForEachMonthOfYear(
      year: year,
      filter: barFilter,
    );
    profiltDataList = repository.getListOfProfitsForEachMonthOfYear(
      year: year,
      filter: barFilter,
    );
    notifyListeners();
  }

  void onChangedYear(String? value) {
    year = value!;
    saleDataList = repository.getListOfSalesForEachMonthOfYear(
      year: value,
      filter: barFilter,
    );
    profiltDataList = repository.getListOfProfitsForEachMonthOfYear(
      year: year,
      filter: barFilter,
    );
    notifyListeners();
  }

  BarChartDataProvider(this.repository) {
    allSalesData = repository.getAllSalesData.then((value) {
      saleDataList = repository.getListOfSalesForEachMonthOfYear(year: year);
      profiltDataList =
          repository.getListOfProfitsForEachMonthOfYear(year: year);
      return value;
    });
  }
}
