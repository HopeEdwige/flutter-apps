import 'package:flutter/material.dart';
import 'package:weight_tracker/util/bmi_utils.dart';
import 'package:weight_tracker/util/list_utils.dart';

class BMIGraph extends StatelessWidget {
  final double graphWidth;
  final double currentValue;
  final double lineGap = 4.1;

  const BMIGraph({Key key, this.graphWidth = 100, this.currentValue = 0})
      : assert(graphWidth != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final double startValue = 14;
    final double endValue = 40;
    final ThemeData theme = Theme.of(context);
    final List<double> graphItems = range(startValue, endValue, step: .5);
    final List<Widget> graph = graphItems
        .map((v) => _buildGraphItem(
              v,
              startValue,
              ((graphWidth + lineGap) / graphItems.length),
              theme,
            ))
        .toList();

    return Container(
      width: graphWidth,
      child: Column(
        children: [
          Row(children: graph),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text('15'),
              ),
              Expanded(
                flex: 3,
                child: Text('18.5'),
              ),
              Expanded(
                flex: 2,
                child: Text('25'),
              ),
              Expanded(
                flex: 4,
                child: Text('30'),
              ),
              Expanded(
                child: Text(
                  '40',
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildGraphItem(double value, double startValue, double width, ThemeData theme) {
    final Map<String, dynamic> data = getLabelAndColorByBMIResult(value, theme);
    return Container(
      width: width,
      color: data['color'],
      height: currentValue == value ? 35 : 25,
      padding: EdgeInsets.symmetric(vertical: 0),
      margin: EdgeInsets.only(left: value != startValue ? lineGap : 0),
    );
  }
}
