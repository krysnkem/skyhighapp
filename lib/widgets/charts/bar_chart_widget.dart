import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../entities/for_sky_api/chart_point.dart';

class BarChartWidget extends StatelessWidget {
  const BarChartWidget({
    Key? key,
    required this.points,
    this.leftTitle,
    this.bottonTitle,
    required this.color,
  }) : super(key: key);

  final List<ChartPoint> points;
  final Color color;

  final Widget? leftTitle, bottonTitle;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constratint) {
      print(constratint);
      return AspectRatio(
        aspectRatio: constratint.maxWidth > 400 &&
                constratint.maxHeight == double.infinity
            ? 16 / 3
            : 16 / 8,
        child: BarChart(
          BarChartData(
            barGroups: _chartGroups(),
            borderData: FlBorderData(
                border: const Border(bottom: BorderSide(), left: BorderSide())),
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: _bottomTitles,
                axisNameWidget: bottonTitle,
              ),
              leftTitles: AxisTitles(
                axisNameWidget: leftTitle,
                sideTitles: SideTitles(showTitles: true, reservedSize: 50),
              ),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles:
                  AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
          ),
          swapAnimationDuration: const Duration(milliseconds: 500),
          swapAnimationCurve: Curves.easeInOut,
        ),
      );
    });
  }

  List<BarChartGroupData> _chartGroups() {
    return points
        .map(
          (point) => BarChartGroupData(
            x: point.x.toInt(),
            barRods: [
              BarChartRodData(
                toY: point.y,
                color: point.y > 0 ? color : Colors.red,
              ),
            ],
          ),
        )
        .toList();
  }

  SideTitles get _bottomTitles => SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          String text = '';
          switch (value.toInt()) {
            case 0:
              text = 'Jan';
              break;
            case 2:
              text = 'Mar';
              break;
            case 4:
              text = 'May';
              break;
            case 6:
              text = 'Jul';
              break;
            case 8:
              text = 'Sep';
              break;
            case 10:
              text = 'Nov';
              break;
          }

          return Text(text);
        },
      );
}
