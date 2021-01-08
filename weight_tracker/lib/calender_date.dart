// Modified version of https://github.com/rknell/calendar_time/blob/master/lib/calendar_time.dart
import 'package:intl/intl.dart';

class CalendarDate {
  DateTime _date;

  DateTime get toDate => _date;

  DateTime add(Duration duration) => _date.add(duration);

  DateTime subtract(Duration duration) => _date.subtract(duration);

  DateTime get dateLocal => _date.toLocal();

  DateFormat dayFormat = DateFormat.EEEE();

  DateFormat fullDayFormat = DateFormat.yMMMMd();

  CalendarDate([this._date]) {
    _date ??= DateTime.now();
  }

  CalendarDate.fromTimeStamp(int timestamp) {
    _date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  }

  String get toHuman {
    final String day = dayFormat.format(dateLocal);

    if (isToday) {
      return 'Today';
    } else if (isTomorrow) {
      return 'Tomorrow';
    } else if (isNextWeek) {
      return '$day';
    } else if (isYesterday) {
      return 'Yesterday';
    } else if (isLastWeek) {
      return 'Last $day';
    } else {
      return fullDayFormat.format(dateLocal);
    }
  }

  bool get isToday {
    if (dateLocal.isAfter(startOfToday) && dateLocal.isBefore(endOfToday)) {
      return true;
    }
    return false;
  }

  bool get isTomorrow {
    if (dateLocal.isAfter(endOfToday) && dateLocal.isBefore(endOfTomorrow)) {
      return true;
    }
    return false;
  }

  bool get isNextWeek {
    if (dateLocal.isAfter(endOfToday) && dateLocal.isBefore(endOfNextWeek)) {
      return true;
    }
    return false;
  }

  bool get isYesterday {
    if (dateLocal.isAfter(startOfYesterday) && dateLocal.isBefore(startOfToday)) {
      return true;
    }
    return false;
  }

  bool get isLastWeek {
    if (dateLocal.isAfter(startOfLastWeek) && dateLocal.isBefore(startOfYesterday)) {
      return true;
    }
    return false;
  }

  DateTime get startOfToday => DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  DateTime get startOfDay => DateTime(_date.year, _date.month, _date.day);

  DateTime get startOfYesterday => startOfToday.subtract(Duration(days: 1));

  DateTime get startOfLastWeek => startOfToday.subtract(Duration(days: 7));

  DateTime get endOfToday => DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59, 59, 999, 999);

  DateTime get endOfDay => DateTime(_date.year, _date.month, _date.day, 23, 59, 59, 999, 999);

  DateTime get endOfTomorrow => endOfToday.add(Duration(days: 1));

  DateTime get endOfNextWeek => endOfToday.add(Duration(days: 7));
}
