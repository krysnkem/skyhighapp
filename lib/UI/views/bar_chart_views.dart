import 'package:flutter/material.dart';

import '../../entities/for_sky_api/chart_point.dart';
import '../charts/bar_chart_widget.dart';
import 'package:collection/collection.dart';

class BarChartView extends StatelessWidget {
  const BarChartView({
    super.key,
    required this.dataList,
    this.leftTitle,
    this.bottonTitle,
    required this.color,
  });

  final List<double> dataList;
  final Widget? leftTitle, bottonTitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return BarChartWidget(
      points: dataList
          .mapIndexed(
            (index, data) => ChartPoint(
              x: index.toDouble(),
              y: data,
            ),
          )
          .toList(),
      leftTitle: leftTitle,
      bottonTitle: bottonTitle,
      color: color,
    );
  }
}
