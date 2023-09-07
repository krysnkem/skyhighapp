import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skyhighapp/providers/piechart_data_provider.dart';

import '../core/fake_api_service.dart';
import '../entities/Indicator_color.dart';
import '../repository/sales_data_repository.dart';
import 'barchart_data_provider.dart';
import 'color_provider.dart';

class AppProviderCollection extends MultiProvider {
  AppProviderCollection({super.key, super.child})
      : super(
          providers: [
            Provider(
              create: (_) => ColorProvider(),
            ),
            Provider(
              create: (_) => IndicatorColor(
                profitColor: Colors.green[600]!,
                salesColor: Colors.blue,
              ),
            ),
            ChangeNotifierProvider(
              create: (_) => BarChartDataProvider(
                SalesDataRepository(FakeApiService()),
              ),
            ),
            ChangeNotifierProxyProvider<BarChartDataProvider,
                PieChartDataProvider>(
              create: (_) => PieChartDataProvider(),
              update: (_, dataProvider, pieChartProvider) =>
                  pieChartProvider!..update(dataProvider),
            ),
          ],
        );
}
