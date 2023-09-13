import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../entities/for_sky_api/chart_point.dart';

class ScatterChartWidget extends StatefulWidget {
  final List<ChartPoint> points;

  const ScatterChartWidget({required this.points, Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<ScatterChartWidget> createState() => _ScatterChartWidgetState();
}

class _ScatterChartWidgetState extends State<ScatterChartWidget> {
  late int showTooltipSpot;

  _ScatterChartWidgetState();

  @override
  void initState() {
    showTooltipSpot = -1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var flTitlesData = FlTitlesData(
      bottomTitles: AxisTitles(sideTitles: _bottomTitles),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
    );
    // var lineTouchTooltipData = LineTouchTooltipData(
    //   tooltipBgColor: Colors.blue,
    //   tooltipRoundedRadius: 20.0,
    //   showOnTopOfTheChartBoxArea: true,
    //   fitInsideHorizontally: true,
    //   tooltipMargin: 0,
    //   getTooltipItems: getTooltipItems,
    // );
    // var lineTouchData2 = LineTouchData(
    //   enabled: true,
    //   handleBuiltInTouches: false,
    //   touchCallback: touchCallback,
    //   touchTooltipData: lineTouchTooltipData,
    //   getTouchedSpotIndicator: getTouchedSpotIndicator,
    //   getTouchLineEnd: (barData, spotIndex) => double.infinity,
    // );

    var scatterChartData = ScatterChartData(
      scatterSpots:
          widget.points.map((point) => ScatterSpot(point.x, point.y)).toList(),
      titlesData: flTitlesData,
    );

    return AspectRatio(
      aspectRatio: 2,
      child: ScatterChart(
        scatterChartData,
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

  // List<TouchedSpotIndicatorData?> getTouchedSpotIndicator(
  //     ScatterChartBarData barData, List<int> indicators) {
  //   return indicators.map((index) {
  //     final line = FlLine(
  //       color: Colors.grey,
  //       strokeWidth: 1,
  //       dashArray: [2, 4],
  //     );
  //     return TouchedSpotIndicatorData(
  //       line,
  //       FlDotData(show: false),
  //     );
  //   }).toList();
  // }
}

SideTitles get _bottomTitles => SideTitles(
      showTitles: true,
      getTitlesWidget: (value, meta) {
        String text = '';
        switch (value.toInt()) {
          case 1:
            text = 'Jan';
            break;
          case 3:
            text = 'Mar';
            break;
          case 5:
            text = 'May';
            break;
          case 7:
            text = 'Jul';
            break;
          case 9:
            text = 'Sep';
            break;
          case 11:
            text = 'Nov';
            break;

          default:
        }

        return Text(text);
      },
    );
