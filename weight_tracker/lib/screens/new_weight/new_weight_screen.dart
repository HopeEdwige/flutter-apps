import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:weight_tracker/models/session.dart';
import 'package:weight_tracker/models/weight.dart';
import 'package:weight_tracker/screens/new_weight/widgets/calendar/index.dart';
import 'package:weight_tracker/services/db_service.dart';
import 'package:weight_tracker/widgets/text_with_measure/index.dart';
import 'package:weight_tracker/widgets/weight_slider/index.dart';
import 'package:weight_tracker/widgets/widget_size/index.dart';

class NewWeightScreen extends StatefulWidget {
  final double selectedWeight;

  const NewWeightScreen({Key key, this.selectedWeight}) : super(key: key);

  @override
  _NewWeightScreenState createState() => _NewWeightScreenState();
}

class _NewWeightScreenState extends State<NewWeightScreen> {
  Size _labelSize;
  DBService _dbService;
  double _selectedWeight;
  CalendarController _calendarController;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    _labelSize = Size(0, 0);
    _selectedWeight = widget.selectedWeight;

    _dbService = new DBService();
    _calendarController = CalendarController();

    super.initState();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    double tapeHeight = size.height / 4.7;

    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
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
                    Navigator.pop(context, false);
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
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Calendar(controller: _calendarController),
            ),
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: size.height / 10),
                  width: size.width,
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          margin: const EdgeInsets.only(bottom: 0),
          width: MediaQuery.of(context).size.width / 1.5,
          height: 55,
          child: FloatingActionButton.extended(
            onPressed: () => _handleSave(context),
            label: Text(
              'Save',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }

  _handleSave(BuildContext context) async {
    final int currentUserId = Provider.of<Session>(context, listen: false).user.id;
    final DateTime selected = _calendarController.selectedDay;
    final DateTime now = DateTime.now();
    final DateTime updated = DateTime(
      selected.year,
      selected.month,
      selected.day,
      now.hour,
      now.minute,
      now.second,
      now.millisecond,
    );
    final int timestamp = (updated.millisecondsSinceEpoch / 1000).round();

    await _dbService.insertWeight(
      Weight(
        userId: currentUserId,
        value: _selectedWeight,
        timestamp: timestamp,
      ),
      currentUserId,
    );

    this._displaySnackBar(context, Text("Record saved successfully!"));

    Navigator.pop(context, true);
  }

  _displaySnackBar(BuildContext context, content) {
    final snackBar = SnackBar(content: content);
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
