import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:weight_tracker/util/list_utils.dart';

class WeightSlider extends StatefulWidget {
  final double value;
  final int minValue;
  final int maxValue;
  final double height;
  final double width;

  final ValueChanged<double> onChanged;

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
  List<double> values = [];
  ScrollController scrollController;

  int get itemExtent => (widget.itemWidth + widget.itemGutterWidth).toInt();

  double get offsetOfValue =>
      ((widget.itemWidth + widget.itemGutterWidth) * values.indexWhere((v) => v == widget.value) - (widget.width / 2)) + widget.itemWidth;

  @override
  void initState() {
    scrollController = new ScrollController();
    super.initState();

    /// todo fix me for smooth rendering :(
    /// idea is, divide in chunks, load the block which has the selected value and on scroll lazy load blocks.
    WidgetsBinding.instance.addPostFrameCallback((_) => Future.delayed(Duration(milliseconds: 210), () {
          loadValues();
        }));
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return NotificationListener(
      onNotification: _onNotification,
      child: new ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: values.length,
        itemBuilder: (BuildContext context, int index) {
          double currentValue = values[index];
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
        },
      ),
    );
  }

  bool _userStoppedScrolling(Notification notification) {
    return notification is UserScrollNotification &&
        notification.direction == ScrollDirection.idle &&
        scrollController.position.activity is! HoldScrollActivity;
  }

  int _offsetToMiddleIndex(double offset) => (offset + widget.width / 2) ~/ itemExtent;

  double _offsetToMiddleValue(double offset) {
    int indexOfMiddleElement = _offsetToMiddleIndex(offset);
    return values[indexOfMiddleElement];
  }

  bool _onNotification(Notification notification) {
    if (notification is ScrollNotification) {
      double middleValue = _offsetToMiddleValue(notification.metrics.pixels);
      if (middleValue != widget.value) {
        widget.onChanged(middleValue);
      }
    }
    return true;
  }

  loadValues() {
    setState(() {
      values = range(widget.minValue, widget.maxValue, step: .1);
      scrollController.jumpTo(offsetOfValue);
    });
  }
}
