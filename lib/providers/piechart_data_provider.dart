import 'package:flutter/material.dart';

import 'package:skyhighapp/providers/barchart_data_provider.dart';

import '../entities/for_sky_api/order_filter.dart';
import '../repository/sales_data_repository.dart';

class PieChartDataProvider with ChangeNotifier {
  late SalesDataRepository repository;

  OrderRegion pieRegionValue = OrderRegion.all;
  SubCategory pieSubCategoryValue = SubCategory.all;
  Segment pieSegmentValue = Segment.all;
  OrderFilter pieFilter = OrderFilter();

  late String year;

  late Map<OrderRegion, double> salesForEachRegion;
  late Map<OrderRegion, double> profitForEachRegion;

  void update(BarChartDataProvider dataProvider) {
    repository = dataProvider.repository;
    year = dataProvider.year;
    updateRegionPieChart();
    notifyListeners();
  }

  double get getFilteredTotalSales {
    return repository.totalFilteredSalesForTheYear(
      year: year,
      filter: pieFilter,
    );
  }

  double get getFilteredTotalProfit {
    final profits = repository.totalFilteredProfitForTheYear(
      year: year,
      filter: pieFilter,
    );
    return profits;
  }

  void updateRegionPieChart() {
    profitForEachRegion = repository.getDetailsOfProfitForEachRegion(
      year: year,
      filter: pieFilter,
    );

    salesForEachRegion = repository.getDetailsOfSalesForEachRegion(
      year: year,
      filter: pieFilter,
    );
  }

  void onChangedSegment(value) {
    pieSegmentValue = value!;
    pieFilter = pieFilter.copyWith(segment: value);
    updateRegionPieChart();
    notifyListeners();
  }

  void onChangedSubcategory(value) {
    pieSubCategoryValue = value!;
    pieFilter = pieFilter.copyWith(subCategory: value);
    updateRegionPieChart();
    notifyListeners();
  }
}
