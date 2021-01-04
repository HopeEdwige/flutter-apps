import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:weight_tracker/util/list_utils.dart';

class WeightSlider extends StatefulWidget {
  final double value;
  final double minValue;
  final double maxValue;
  final double height;
  final double width;

  final ValueChanged<double> onChanged;

  final double step = .1;
  final double itemWidth = 20;
  final double itemGutterWidth = 10;

  WeightSlider({
    Key key,
    @required this.minValue,
    @required this.maxValue,
    @required this.value,
    this.onChanged,
    this.height,
    @required this.width,
  }) : super(key: key);

  @override
  _WeightSliderState createState() => _WeightSliderState();
}

class _WeightSliderState extends State<WeightSlider> {
  List<double> leftValues = [];
  List<double> rightValues = [];
  ScrollController scrollController;

  List<double> get values => [...leftValues, ...rightValues];

  double get itemExtent => (widget.itemWidth + widget.itemGutterWidth);

  double get offsetOfValue =>
      ((widget.itemWidth + widget.itemGutterWidth) * values.indexOf(widget.value) - (widget.width / 2)) + widget.itemWidth;

  @override
  void initState() {
    leftValues = generateLeftItems(widget.value, widget.minValue);
    rightValues = [widget.value, ...generateRightItems(widget.value, widget.maxValue)];
    scrollController = new ScrollController(initialScrollOffset: offsetOfValue, keepScrollOffset: true);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: _onNotification,
      child: CustomScrollView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverFixedExtentList(
            itemExtent: itemExtent,
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) => _buildItem(leftValues[index]),
              childCount: leftValues.length,
            ),
          ),
          SliverFixedExtentList(
            itemExtent: itemExtent,
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) => _buildItem(rightValues[index]),
              childCount: rightValues.length,
            ),
          ),
        ],
        controller: scrollController,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  int _offsetToMiddleIndex(double offset) => (offset + widget.width / 2) ~/ itemExtent;

  double _offsetToMiddleValue(double offset) {
    int indexOfMiddleElement = _offsetToMiddleIndex(offset);
    return values[indexOfMiddleElement];
  }

  bool _onNotification(Notification notification) {
    if (notification is ScrollNotification) {
      final double offset = notification.metrics.pixels;
      final double middleValue = _offsetToMiddleValue(offset);
      if (middleValue != widget.value) {
        widget.onChanged(middleValue);
      }
    }
    return true;
  }

  generateLeftItems(currentValue, min) {
    return range(min, currentValue - widget.step, step: widget.step);
  }

  generateRightItems(currentValue, max) {
    return range(currentValue + widget.step, max, step: widget.step);
  }

  Widget _buildItem(currentValue) {
    final ThemeData theme = Theme.of(context);
    bool isCurrentSelected = currentValue == widget.value;
    bool currentValueHasDecimal = currentValue.floorToDouble() != currentValue;

    double lineWidth = 3;
    double lineHeight = 25;
    double margin = widget.itemGutterWidth;
    Color lineColor = theme.textTheme.headline5.color;

    if (isCurrentSelected) {
      lineWidth = 8;
      lineHeight = 50;
      margin = widget.itemGutterWidth - 5;
      lineColor = theme.colorScheme.primary;
    } else if (currentValueHasDecimal) {
      lineWidth = 2;
      lineHeight = 10;
      lineColor = theme.textTheme.bodyText2.color;
    }

    return Container(
      width: 20,
      height: widget.height,
      // color: Colors.blue,
      margin: EdgeInsets.only(left: margin),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedContainer(
            // Define how long the animation should take.
            duration: Duration(milliseconds: 100),
            // Provide an optional curve to make the animation feel smoother.
            curve: Curves.fastOutSlowIn,
            width: lineWidth,
            height: lineHeight,
            decoration: ShapeDecoration(
              color: lineColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            currentValueHasDecimal ? '' : currentValue.toStringAsFixed(0),
            style: TextStyle(fontSize: 14),
          )
        ],
      ),
    );
  }
}
