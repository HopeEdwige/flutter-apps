//Modified version of (https://github.com/PramodJoshi/toggle_switch/blob/master/lib/toggle_switch.dart)

import 'package:flutter/material.dart';

class ToggleSwitch extends StatelessWidget {
  final List<String> labels;
  final ValueChanged<int> onToggle;
  final int initialLabelIndex;
  final Color selectionColor;
  final double minWidth;
  final double minHeight;

  ToggleSwitch({
    Key key,
    @required this.labels,
    @required this.initialLabelIndex,
    this.onToggle,
    this.selectionColor,
    this.minWidth = 100,
    this.minHeight = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    double itemWidth = _calculateWidth(context);
    double itemSelectedLayerWidth = itemWidth + 5;
    double containerHeight = minHeight;
    double containerWidth = itemWidth * labels.length;
    int animationDuration = 400 ~/ labels.length;

    Color itemSelectedLayerColor = selectionColor ?? theme.buttonColor;

    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Container(
        color: Colors.grey[400],
        height: containerHeight,
        width: containerWidth,
        child: Stack(
          children: [
            AnimatedPositioned(
              width: itemSelectedLayerWidth,
              height: containerHeight,
              child: Container(
                decoration: BoxDecoration(
                  color: itemSelectedLayerColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                width: itemSelectedLayerWidth,
              ),
              left: initialLabelIndex * itemWidth,
              duration: Duration(milliseconds: animationDuration),
              curve: Curves.ease,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(labels.length, (index) {
                final active = index == initialLabelIndex;

                return GestureDetector(
                  onTap: () => onToggle(index),
                  child: Container(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    constraints: BoxConstraints(maxWidth: itemWidth),
                    alignment: Alignment.center,
                    color: Colors.transparent,
                    child: Text(
                      labels[index],
                      style: TextStyle(
                        color: active ? theme.colorScheme.primaryVariant : Colors.black54,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  double _calculateWidth(BuildContext context) {
    int totalLabels = labels.length;
    double extraWidth = 0.90 * totalLabels;
    double screenWidth = MediaQuery.of(context).size.width;
    return (totalLabels + extraWidth) * minWidth < screenWidth ? minWidth : screenWidth / (totalLabels + extraWidth);
  }
}
