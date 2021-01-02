import 'package:flutter/material.dart';
import 'package:weight_tracker/models/gender.dart';
import 'package:weight_tracker/screens/signup_screen/widgets/gender_selector/gender_selector.dart';

class GenderPage extends StatefulWidget {
  final Gender initialSelected;

  GenderPage({Key key, this.initialSelected}) : super(key: key);

  @override
  _GenderPageState createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  Gender _selected;

  @override
  void initState() {
    _selected = widget.initialSelected ?? genderList[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;

    double selectorHeight = size.height - (size.height / 3);

    return Container(
      width: size.width,
      height: size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 40),
          GenderSelector(
            width: size.width,
            height: size.height - (size.height / 3),
            initialSelected: _selected.id,
            highLightColors: [
              theme.brightness == Brightness.light ? Color.fromRGBO(255, 209, 213, 1) : Colors.pink.shade200.withOpacity(.8),
              theme.brightness == Brightness.light ? Color.fromRGBO(218, 245, 253, 1) : Colors.tealAccent.shade100.withOpacity(.5),
            ],
            onChanged: (gender) {
              print('Currently Selected ${gender.title}');
            },
          ),
          SizedBox(
            height: (size.height - selectorHeight) / 8,
          ),
          SizedBox(
            width: size.width / 1.8,
            height: selectorHeight / 10, // match_parent
            child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Next',
                  style: TextStyle(fontSize: 18),
                )),
          )
        ],
      ),
    );
  }
}
