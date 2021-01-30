import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/material.dart';
import 'package:weight_tracker/models/weight.dart';

class Chart extends StatelessWidget {
  final List<Weight> history;

  const Chart({Key key, this.history}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);

    var lineData = _buildLineData();
    var d = _getStartEndDate();

    return SizedBox(
      width: size.width,
      height: 180,
      child: BezierChart(
        bezierChartScale: BezierChartScale.MONTHLY,
        fromDate: d['start'],
        toDate: d['end'],
        series: [
          BezierLine(
            lineColor: theme.colorScheme.primary,
            lineStrokeWidth: 2,
            data: lineData,
          ),
        ],
        config: BezierChartConfig(
          contentWidth: size.width * 12,
          showDataPoints: false,
          showVerticalIndicator: true,
          verticalIndicatorStrokeWidth: 5,
          startYAxisFromNonZeroValue: false,
          verticalIndicatorColor: Colors.white.withAlpha(40),
          displayYAxis: true,
        ),
      ),
    );
  }

  List<DataPoint> _buildLineData() {
    return this.history.map((record) {
      return DataPoint<DateTime>(
        value: record.value,
        xAxis: DateTime.fromMillisecondsSinceEpoch(record.timestamp * 1000),
      );
    }).toList(growable: false);
  }

  _getStartEndDate() {
    var list = [...this.history];

    list.sort((a, b) => a.timestamp.toString().compareTo(b.timestamp.toString()));

    return {
      'start': DateTime.fromMillisecondsSinceEpoch(list.first.timestamp * 1000),
      'end': DateTime.fromMillisecondsSinceEpoch(list.last.timestamp * 1000),
    };
  }
}
