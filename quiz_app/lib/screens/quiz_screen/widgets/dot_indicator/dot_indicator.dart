import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DotIndicator extends StatelessWidget {
  final int _steps;
  final int dotsCount;
  final int position;
  final bool showFinishDot;
  final double dotSize;

  final Color dotColor;
  final Color completedDotColor;
  final Color lineColor;
  final Color completedLineColor;
  final Color activeDotColor;
  final Color activeBorderColor;
  final Color finishDotColor;

  const DotIndicator({
    Key key,
    this.dotSize = 10,
    this.position = 0,
    this.showFinishDot = true,
    @required this.dotsCount,
    @required this.lineColor,
    @required this.dotColor,
    @required this.completedDotColor,
    @required this.activeDotColor,
    @required this.activeBorderColor,
    @required this.completedLineColor,
    this.finishDotColor,
  })  : assert(dotsCount != null && dotsCount > 0),
        assert(position != null),
        assert(dotColor != null),
        assert(completedDotColor != null),
        assert(lineColor != null),
        assert(activeDotColor != null),
        assert(activeBorderColor != null),
        assert(completedLineColor != null),
        assert(finishDotColor != null),
        this._steps = dotsCount + 1,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var widgets = <Widget>[];

    for (var index = 0; index < _steps; index++) {
      widgets.add(_buildDot(index));

      if (index != dotsCount) {
        widgets.add(_buildLine(index));
      }
    }

    return Row(
      children: widgets,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
    );
  }

  Widget _buildDot(int index) {
    final isLast = index == _steps - 1;

    if (isLast && showFinishDot) {
      final size = Size.square(dotSize + 15);
      return Container(
        width: size.width,
        height: size.height,
        child: Icon(
          FontAwesomeIcons.trophy,
          color: Colors.white,
          size: size.width / 2,
        ),
        decoration: ShapeDecoration(
          shape: CircleBorder(),
          color: finishDotColor,
        ),
      );
    }

    final isActive = position == index;
    final isCompleted = position > index;
    final size = isActive ? Size.square(dotSize + 10) : Size.square(dotSize);
    final color = isActive
        ? activeDotColor
        : isCompleted
            ? completedDotColor
            : dotColor;

    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(100),
        border: isActive ? Border.all(width: 4, color: activeBorderColor) : null,
      ),
    );
  }

  Widget _buildLine(int index) {
    final color = Color.lerp(completedLineColor, lineColor, position <= index ? 1.0 : 0.0);

    return Expanded(
      child: Container(
        height: 2,
        color: color,
      ),
    );
  }
}
