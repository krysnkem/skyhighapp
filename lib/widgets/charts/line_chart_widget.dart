import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../entities/for_sky_api/chart_point.dart';

class LineChartWidget extends StatefulWidget {
  final List<ChartPoint> points;

  const LineChartWidget({required this.points, Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  late int showTooltipSpot;

  _LineChartWidgetState();

  @override
  void initState() {
    showTooltipSpot = -1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var lineBarsData = [
      LineChartBarData(
        spots: widget.points.map((point) => FlSpot(point.x, point.y)).toList(),
        isCurved: false,
        // dotData: const FlDotData(
        //   show: false,
        // ),
        color: Colors.red,
      ),
    ];
    var flTitlesData = FlTitlesData(
      bottomTitles: AxisTitles(sideTitles: _bottomTitles),
      topTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      rightTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      leftTitles: const AxisTitles(
        axisNameSize: 12,
        sideTitles: SideTitles(showTitles: true, reservedSize: 50),
      ),
    );
    var lineTouchTooltipData = LineTouchTooltipData(
      tooltipBgColor: Colors.blue,
      tooltipRoundedRadius: 20.0,
      showOnTopOfTheChartBoxArea: true,
      fitInsideHorizontally: true,
      tooltipMargin: 0,
      getTooltipItems: getTooltipItems,
    );
    var lineTouchData2 = LineTouchData(
      enabled: true,
      handleBuiltInTouches: false,
      touchCallback: touchCallback,
      touchTooltipData: lineTouchTooltipData,
      getTouchedSpotIndicator: getTouchedSpotIndicator,
      getTouchLineEnd: (barData, spotIndex) => double.infinity,
    );

    return AspectRatio(
      aspectRatio: 2,
      child: LineChart(
        LineChartData(
          lineBarsData: lineBarsData,
          lineTouchData: lineTouchData2,
          borderData: FlBorderData(
            border: const Border(
              bottom: BorderSide(),
              left: BorderSide(),
            ),
          ),
          gridData: const FlGridData(show: false),
          titlesData: flTitlesData,
          showingTooltipIndicators: showTooltipSpot != -1
              ? [
                  ShowingTooltipIndicators([
                    LineBarSpot(
                      lineBarsData[0],
                      showTooltipSpot,
                      lineBarsData[0].spots[showTooltipSpot],
                    )
                  ])
                ]
              : [],
        ),
        duration: const Duration(milliseconds: 1000), // Optional
        curve: Curves.linear,
      ),
    );
  }

  List<LineTooltipItem?> getTooltipItems(List<LineBarSpot> touchedSpots) {
    return touchedSpots.map(
      (touchedSpot) {
        const textStyle = TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        );
        return LineTooltipItem(
          widget.points[touchedSpot.spotIndex].y.toStringAsFixed(2),
          textStyle,
        );
      },
    ).toList();
  }

  void touchCallback(FlTouchEvent event, LineTouchResponse? touchResponse) {
    if (touchResponse?.lineBarSpots != null && event is FlTapUpEvent) {
      setState(() {
        final spotIndex = touchResponse?.lineBarSpots?[0].spotIndex ?? -1;
        if (spotIndex == showTooltipSpot) {
          showTooltipSpot = -1;
        } else {
          showTooltipSpot = spotIndex;
        }
      });
    }
  }

  List<TouchedSpotIndicatorData?> getTouchedSpotIndicator(
      LineChartBarData barData, List<int> indicators) {
    return indicators.map((index) {
      final line = FlLine(
        color: Colors.grey,
        strokeWidth: 1,
        dashArray: [2, 4],
      );
      return TouchedSpotIndicatorData(
        line,
        FlDotData(show: false),
      );
    }).toList();
  }
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

          default:
        }

        return Text(
          text,
          style: const TextStyle(fontSize: 13),
        );
      },
    );
