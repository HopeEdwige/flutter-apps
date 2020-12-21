import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CountDown extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CountDownState();
  }
}

class CountDownState extends State<CountDown> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: _appBarActions(),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Container(
          padding: EdgeInsets.only(top: 80, bottom: 20),
          child: Column(
            children: <Widget>[
              _title(),
              SizedBox(height: 20),
              _duration(),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        elevation: 0.0,
        child: Icon(
          Icons.arrow_circle_down,
          size: 40,
        ),
        foregroundColor: Colors.white70,
        backgroundColor: Colors.transparent,
      ),
    );
  }

  List<Widget> _appBarActions() {
    Widget layoutModeButton = Padding(
        padding: EdgeInsets.only(right: 20.0),
        child: GestureDetector(
          onTap: () {},
          child: Icon(Icons.list),
        ));

    return [layoutModeButton];
  }

  Widget _title() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Corona virus',
            style: TextStyle(
              fontSize: 50,
              backgroundColor: Colors.blue,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Ending in:',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ],
    );
  }

  Widget _duration() {
    int endTimestamp = 1609459201; // todo fix me :)
    return new Container(
      width: 400,
      height: 400,
      margin: const EdgeInsets.all(10),
      decoration: new BoxDecoration(
        color: Theme.of(context).primaryColor,
        shape: BoxShape.circle,
      ),
      child: StreamBuilder(
        stream: Stream.periodic(Duration(seconds: 1), (i) => i),
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          DateTime now = DateTime.now();
          DateTime endDate = DateTime.fromMillisecondsSinceEpoch(endTimestamp * 1000);
          Duration remaining = Duration(milliseconds: endDate.millisecondsSinceEpoch - now.millisecondsSinceEpoch);

          return _remainingDateAndTime(remaining);
        },
      ),
    );
  }

  Widget _remainingDateAndTime(Duration remaining) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            Text(
              '${remaining.inDays}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 100),
            ),
            SizedBox(
              width: 7,
            ),
            Text(
              'Days',
              style: TextStyle(fontSize: 40, fontStyle: FontStyle.italic),
            )
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                      text: formattedTimeString('hh', remaining),
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 55),
                      children: <TextSpan>[
                        TextSpan(text: ' : '),
                      ]),
                ),
                SizedBox(
                  width: 7,
                ),
                Text(
                  'Hours',
                  style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                      text: formattedTimeString('mm', remaining),
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 55),
                      children: <TextSpan>[
                        TextSpan(text: ' : '),
                      ]),
                ),
                SizedBox(
                  width: 7,
                ),
                Text(
                  'Minutes',
                  style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    text: TextSpan(
                  text: formattedTimeString('ss', remaining),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 55),
                )),
                SizedBox(
                  width: 7,
                ),
                Text(
                  'Seconds',
                  style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 10),
      ],
    );
  }
}

String formattedTimeString(String format, Duration remaining) {
  return DateFormat(format).format(
    DateTime.fromMillisecondsSinceEpoch(
      remaining.inMilliseconds,
    ),
  );
}
