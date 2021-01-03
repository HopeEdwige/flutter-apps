import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:weight_tracker/widgets/weight_slider/index.dart';
import 'package:weight_tracker/widgets/text_with_measure/index.dart';
import 'package:weight_tracker/screens/new_weight/widgets/calendar/index.dart';
import 'package:weight_tracker/widgets/widget_size/index.dart';

class NewWeightScreen extends StatefulWidget {
  @override
  _NewWeightScreenState createState() => _NewWeightScreenState();
}

class _NewWeightScreenState extends State<NewWeightScreen> {
  double _selectedWeight;
  Size _labelSize;

  @override
  void initState() {
    _labelSize = Size(0, 0);
    _selectedWeight = 78.5;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    double tapeHeight = size.height / 4.7;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          backgroundColor: theme.scaffoldBackgroundColor,
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  size: 28,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            )
          ],
          title: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'New Weight',
              style: TextStyle(fontSize: theme.textTheme.headline4.fontSize),
            ),
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Calendar(),
            ),
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: size.height / 10),
                  height: tapeHeight,
                  // color: Colors.red,
                  child: WeightSlider(
                    minValue: 45,
                    maxValue: 160,
                    value: _selectedWeight,
                    width: size.width,
                    height: tapeHeight,
                    onChanged: (selected) => setState(() {
                      _selectedWeight = selected;
                    }),
                  ),
                ),
                Positioned(
                  top: 30,
                  left: (size.width - _labelSize.width) / 2,
                  child: WidgetSize(
                    onChange: (Size size) {
                      setState(() {
                        _labelSize = size;
                      });
                    },
                    child: TextWithMeasure(
                      text: _selectedWeight.toStringAsFixed(2),
                      fontSize: size.width / 5.5,
                      color: theme.textTheme.headline5.color,
                      measureFontSize: theme.textTheme.headline5.fontSize,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 0),
        width: MediaQuery.of(context).size.width / 1.5,
        height: 55,
        child: FloatingActionButton.extended(
          onPressed: () => {},
          label: Text(
            'Save',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
