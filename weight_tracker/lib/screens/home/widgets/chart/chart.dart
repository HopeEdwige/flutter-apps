import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Chart extends StatelessWidget {
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: 180,
      child: LineChart(
        _buildChartData(size: size, barData: _buildLineChartBarData()),
      ),
    );
  }

  _buildChartData({Size size, LineChartBarData barData}) {
    const double margin = 10;
    const double fontSize = 15;
    const textStyles = const TextStyle(color: Color(0xff68737d), fontSize: fontSize);

    // random fraction size :)
    int ratio = (size.aspectRatio * 100).toInt();
    double reverseSizeX = ((ratio * 5) + size.width) / 13;

    return LineChartData(
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => textStyles,
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'MAR';
              case 5:
                return 'JUN';
              case 8:
                return 'SEP';
            }
            return '';
          },
          margin: margin,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => textStyles,
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10.2kg';
              case 3:
                return '30.5kg';
              case 5:
                return '50.0kg';
            }
            return '';
          },
          reservedSize: reverseSizeX,
          margin: margin,
        ),
      ),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 5.5,
      lineBarsData: [barData],
    );
  }

  _buildLineChartBarData() {
    return LineChartBarData(
      spots: [
        FlSpot(0, 3),
        FlSpot(2.6, 2),
        FlSpot(4.9, 5),
        FlSpot(6.8, 3.1),
        FlSpot(8, 4),
        FlSpot(9.5, 3),
        FlSpot(11, 4),
      ],
      isCurved: true,
      colors: gradientColors,
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(
        show: true,
        colors: gradientColors.map((color) => color.withOpacity(0.1)).toList(),
      ),
    );
  }
}
