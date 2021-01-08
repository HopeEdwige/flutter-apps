import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  final CalendarController controller;

  const Calendar({Key key, @required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.only(top: size.height / 25),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: TableCalendar(
          calendarController: controller,
          calendarStyle: CalendarStyle(
            highlightToday: false,
            outsideDaysVisible: false,
            selectedColor: theme.colorScheme.primary,
            weekendStyle: TextStyle(color: Color.fromRGBO(141, 142, 153, 1), fontSize: 16),
            weekdayStyle: TextStyle(color: Color.fromRGBO(141, 142, 153, 1), fontSize: 16),
            holidayStyle: TextStyle(),
            selectedStyle: TextStyle(color: theme.colorScheme.primaryVariant, fontWeight: FontWeight.bold),
          ),
          headerStyle: HeaderStyle(
            headerMargin: const EdgeInsets.only(bottom: 14),
            centerHeaderTitle: true,
            formatButtonVisible: false,
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: theme.textTheme.bodyText2.color,
              fontSize: theme.textTheme.headline5.fontSize,
            ),
            leftChevronIcon: Icon(
              Icons.chevron_left,
              size: 35,
              color: theme.textTheme.bodyText2.color,
            ),
            rightChevronIcon: Icon(
              Icons.chevron_right,
              size: 35,
              color: theme.textTheme.bodyText2.color,
            ),
          ),
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: TextStyle(color: theme.textTheme.headline5.color, fontWeight: FontWeight.bold),
            weekendStyle: TextStyle(color: theme.textTheme.headline5.color, fontWeight: FontWeight.bold),
            dowTextBuilder: (date, locale) => DateFormat.E(locale).format(date)[0],
          ),
        ),
      ),
    );
  }
}
