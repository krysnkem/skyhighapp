import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skyhighapp/UI/views/filters/barchart_filters/barchart_filter_views.dart';

import '../../entities/for_sky_api/Indicator_color.dart';
import '../../providers/barchart_data_provider.dart';
import 'bar_chart_views.dart';

class BarChartDataVisualizaion extends StatelessWidget {
  const BarChartDataVisualizaion({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 30,
        ),
        SizedBox(height: 200, child: SalesBarChart()),
        SizedBox(
          height: 30,
        ),
        Text(
          "Filter by:",
          style: TextStyle(fontSize: 17),
        ),
        SizedBox(
          height: 5,
        ),
        RegionFilter(),
        SizedBox(
          height: 5,
        ),
        SegmentFilter(),
        SubCategoryFilter(),
        SizedBox(
          height: 30,
        ),
        ProfitsBarChart(),
      ],
    );
  }
}

class ProfitsBarChart extends StatelessWidget {
  const ProfitsBarChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BarChartView(
          dataList: context.select<BarChartDataProvider, List<double>>(
            (provider) => provider.profiltDataList,
          ),
          leftTitle: const Text('Profit'),
          color: context.read<IndicatorColor>().profitColor,
        ),
      ],
    );
  }
}

class SalesBarChart extends StatelessWidget {
  const SalesBarChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BarChartView(
          dataList: context.select<BarChartDataProvider, List<double>>(
              (provider) => provider.saleDataList),
          leftTitle: const Text('Sales'),
          color: context.read<IndicatorColor>().salesColor,
        ),
      ],
    );
  }
}
