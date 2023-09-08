import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skyhighapp/providers/bottom_nav_provider.dart';
import 'package:skyhighapp/providers/location_provider.dart';
import 'package:skyhighapp/providers/map_provider.dart';
import 'package:skyhighapp/providers/piechart_data_provider.dart';

import '../api/services/location_serivice.dart';
import '../core/fake_api_service.dart';
import '../entities/for_sky_api/Indicator_color.dart';
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
              create: (context) => LocationProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => BottomNavProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => MapProvider(MapLocationService()),
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
