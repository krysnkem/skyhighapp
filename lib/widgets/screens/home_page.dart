import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skyhighapp/providers/bottom_nav_provider.dart';
import 'package:skyhighapp/widgets/screens/map_location_view.dart';
import 'package:skyhighapp/widgets/views/filters/piechart_filters/regional_filters.dart';

import '../../providers/barchart_data_provider.dart';
import '../views/bar_chart_visualization.dart';
import '../views/filters/year_filter.dart';
import '../views/indicator_views.dart';
import '../views/loading_widget.dart';
import '../views/profits_regional_piechart.dart';
import '../views/sales_regional_piechart.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final pageIndex = context
        .select<BottomNavProvider, int>((provider) => provider.pageIndex);
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   title: Text(title),
      // ),
      body: [
        const SafeArea(child: DataVisualizationView()),
        const MapLocationView(),
      ][pageIndex],
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          context.read<BottomNavProvider>().pageIndex = index;
        },
        indicatorColor: Theme.of(context).indicatorColor,
        selectedIndex: pageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.trending_up),
            label: 'Data History',
          ),
          NavigationDestination(
            icon: Icon(Icons.public),
            label: 'Map',
          ),
        ],
      ),
    );
  }
}

class DataVisualizationView extends StatelessWidget {
  const DataVisualizationView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
        future: context.read<BarChartDataProvider>().allSalesData,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error occurred"),
            );
          }
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return const LoadingWidget();

            case ConnectionState.done:
              {
                if (snapshot.hasData) {
                  // return ListView.builder(
                  //   itemCount: dataList.length,
                  //   itemBuilder: (context, index) {
                  //     final data = dataList[index];
                  //     return ListTile(
                  //       title: Text(data.orderId),
                  //     );
                  //   },
                  // );

                  return const Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Sales and Profit for ",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          YearFilter(),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SalesAndProfitIndicator(),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Monthly Insights",
                                style: TextStyle(
                                  fontSize: 17,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              BarChartDataVisualizaion(),
                              SizedBox(
                                height: 80,
                              ),
                              Text(
                                "Regional Analysis",
                                style: TextStyle(
                                  fontSize: 17,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              PiechartDataVisualization()
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }
            default:
              return const LoadingWidget();
          }
          return const LoadingWidget();
        },
      ),
    );
  }
}

class PiechartDataVisualization extends StatelessWidget {
  const PiechartDataVisualization({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SalesRegionalPieChart(),
        ProfitsRegionalPieChart(),
        SizedBox(
          height: 20,
        ),
        SegmentFilterForRegion(),
        SubCategoryFilterForRegion(),
      ],
    );
  }
}
