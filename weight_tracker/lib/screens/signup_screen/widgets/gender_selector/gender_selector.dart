import 'package:flutter/material.dart';
import 'package:weight_tracker/models/gender.dart';
import 'package:weight_tracker/widgets/toggle_switch/index.dart';

class GenderSelector extends StatefulWidget {
  final double width;
  final double height;
  final int initialSelected;
  final List<Color> highLightColors;
  final ValueChanged<Gender> onChanged;

  GenderSelector({
    Key key,
    this.width,
    this.height,
    this.onChanged,
    this.highLightColors,
    this.initialSelected = 0,
  }) : super(key: key);

  @override
  _GenderSelectorState createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
  int selectedIndex;
  PageController controller;

  @override
  initState() {
    super.initState();

    selectedIndex = widget.initialSelected;
    controller = new PageController(
      initialPage: selectedIndex,
      keepPage: false,
      viewportFraction: 0.5,
    );
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      width: widget.width,
      height: widget.height,
      child: Column(
        children: <Widget>[
          Container(
            height: widget.height - (widget.height / 8),
            child: new PageView.builder(
                controller: controller,
                itemCount: genderList.length,
                onPageChanged: (value) => _handleOnPageChange(value),
                itemBuilder: (context, index) => _buildPageItem(index, theme)),
          ),
          ToggleSwitch(
            minWidth: widget.width / 1.5,
            initialLabelIndex: selectedIndex,
            labels: genderList.map((gender) => gender.title).toList(),
            onToggle: (selected) => _handleOnTap(selected),
          )
        ],
      ),
    );
  }

  _buildPageItem(int index, ThemeData theme) {
    return new AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        double value = 1.0;
        double circleValue = 1.0;
        double boxHeight = widget.height / 1.3;
        double boxWidth = (widget.width / 2);

        if (controller.position.haveDimensions) {
          value = controller.page - index;
          value = (1 - (value.abs() * .7)).clamp(0.0, 1.0);

          circleValue = controller.page - index;
          circleValue = (1 - circleValue.abs() * 1).clamp(0.0, 1.0);
        }

        return Center(
          child: Stack(
            children: [
              Positioned(
                width: Curves.easeOut.transform(circleValue) * boxWidth,
                height: Curves.easeOut.transform(circleValue) * boxWidth,
                child: AnimatedContainer(
                  curve: Curves.easeIn,
                  duration: Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.highLightColors[index],
                  ),
                ),
              ),
              SizedBox(
                child: child,
                height: Curves.easeOut.transform(value) * boxHeight,
                width: Curves.easeOut.transform(value) * boxWidth,
              )
            ],
          ),
        );
      },
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => _handleOnTap(index),
        child: Image.asset(
          genderList[index].illustrationPath,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }

  void _handleOnTap(int index) {
    controller.animateToPage(
      index,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 400),
    );
  }

  void _handleOnPageChange(int index) {
    setState(() {
      selectedIndex = index;
      widget.onChanged(genderList[index]);
    });
  }
}
