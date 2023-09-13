import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:skyhighapp/entities/for_sky_api/pie_sector.dart';

class PieChartWidget extends StatelessWidget {
  final List<PieSector> sectors;
  final double total;

  const PieChartWidget({required this.sectors, Key? key, required this.total})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return AspectRatio(
        aspectRatio: constraints.maxWidth > 400 &&
                constraints.maxHeight == double.infinity
            ? 4.0
            : 2.3,
        child: PieChart(
          PieChartData(
            sections: _chartSections(sectors),
            centerSpaceRadius: 0.0,
            sectionsSpace: 0.0,
          ),
          swapAnimationDuration: const Duration(milliseconds: 500),
          swapAnimationCurve: Curves.easeInOut,
        ),
      );
    });
  }

  List<PieChartSectionData> _chartSections(List<PieSector> sectors) {
    final List<PieChartSectionData> list = [];
    for (var sector in sectors) {
      const double radius = 100.0;
      final data = PieChartSectionData(
          color: sector.color,
          value: sector.value,
          radius: radius,
          title: sector.value > 0
              ? "${sector.title}\n${(sector.value).toStringAsFixed(1)}%"
              : "",
          titleStyle: const TextStyle(
            color: Colors.white,
          ));
      list.add(data);
    }
    return list;
  }
}
