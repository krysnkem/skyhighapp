import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skyhighapp/entities/for_sky_api/Indicator_color.dart';

import '../../providers/barchart_data_provider.dart';

class SalesAndProfitIndicator extends StatelessWidget {
  const SalesAndProfitIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [SalesIndicator(), ProfitIndicator()],
    );
  }
}

class SalesIndicator extends StatelessWidget {
  const SalesIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    print('Sales Indicator built');

    final totalSales = context.select<BarChartDataProvider, String>(
      (barChartProvider) => barChartProvider.getTotalSales,
    );
    return Row(
      children: [
        const Text("Total Sales: "),
        Text(
          totalSales,
          style: TextStyle(
            color: context.read<IndicatorColor>().salesColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class ProfitIndicator extends StatelessWidget {
  const ProfitIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    print('Profit Indicator built');
    final totalSales = context.select<BarChartDataProvider, String>(
      (barChartProvider) => barChartProvider.getTotalProfit,
    );
    return Row(
      children: [
        const Text("Net Profit: "),
        Text(
          totalSales,
          style: TextStyle(
            color: context.read<IndicatorColor>().profitColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
