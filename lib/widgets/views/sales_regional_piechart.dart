import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skyhighapp/entities/Indicator_color.dart';
import 'package:skyhighapp/utilities/capitalize.dart';

import '../../entities/for_sky_api/order_filter.dart';
import '../../entities/for_sky_api/pie_sector.dart';
import '../../providers/color_provider.dart';
import '../../providers/piechart_data_provider.dart';
import '../charts/pie_chart_widget.dart';

class SalesRegionalPieChart extends StatelessWidget {
  const SalesRegionalPieChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    print('Sales regional pie chart built');
    final colors = context.read<ColorProvider>().materialColors;

    List<PieSector> sectors = [];
    final detailsOfSalesForEachRegion =
        context.select<PieChartDataProvider, Map<OrderRegion, double>>(
            (chartData) => chartData.salesForEachRegion);

    final totalFiltered = context.select<PieChartDataProvider, double>(
        (chartData) => chartData.getFilteredTotalSales);
    detailsOfSalesForEachRegion.forEach(
      (key, value) {
        if (key != OrderRegion.all ) {
          final sector = PieSector(
            color: colors[key.index],
            value: (value / totalFiltered) * 100,
            title: key.name.capitalize(),
          );
          sectors.add(sector);
        }
      },
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 50,
        ),
        Row(
          children: [
            const Spacer(
              flex: 1,
            ),
            Text(
              'Sales',
              style: TextStyle(
                fontSize: 16,
                color: context.read<IndicatorColor>().salesColor,
              ),
            ),
            const Spacer(
              flex: 3,
            ),
          ],
        ),
        PieChartWidget(
          sectors: sectors,
          total: totalFiltered,
        ),
      ],
    );
  }
}
