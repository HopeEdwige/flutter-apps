import 'package:intl/intl.dart';

String formattedTimeString(String format, Duration remaining) {
  return DateFormat(format).format(
    DateTime.fromMillisecondsSinceEpoch(
      remaining.inMilliseconds,
    ),
  );
}
