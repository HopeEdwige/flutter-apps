import 'package:flutter/material.dart';
import 'package:countdown_timer/util/format_utils.dart';

class Countdown extends StatelessWidget {
  final int endDate;
  final dynamic backgroundColor;

  const Countdown({Key key, this.endDate, this.backgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 400,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
      ),
      child: StreamBuilder(
        stream: Stream.periodic(Duration(seconds: 1), (i) => i),
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          DateTime now = DateTime.now();
          DateTime endDateEpoch = DateTime.fromMillisecondsSinceEpoch(endDate);
          Duration remaining = Duration(milliseconds: endDateEpoch.millisecondsSinceEpoch - now.millisecondsSinceEpoch);

          return _buildRemainingDateAndTime(remaining);
        },
      ),
    );
  }

  Widget _buildRemainingDateAndTime(Duration remaining) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${remaining.inDays}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 100),
            ),
            SizedBox(
              width: 4,
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
      ],
    );
  }
}
