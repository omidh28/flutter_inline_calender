library inline_calender;

import 'package:flutter/material.dart';
import 'package:inline_calender/src/calender_model.dart';
import 'package:inline_calender/src/calender_row.dart';
import 'package:inline_calender/src/utilities.dart';
import 'package:inline_calender/src/weekdays_row.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

class InlineCalender extends StatefulWidget implements PreferredSizeWidget {
  /// The center of the calender
  final DateTime startDate;

  /// Set true to use shamsi/jalali date
  final bool isShamsi;

  /// Number of week available from both ends of start day
  final int maxWeeks;

  /// Handler when date changes
  final Function(DateTime) onChange;

  /// list of dates to add circlur color under text lable
  final Map<DateTime, Color> coloredDateTimes;

  /// set the total height of app bar
  final double height;

  const InlineCalender({
    Key key,
    @required this.startDate,
    @required this.onChange,
    this.isShamsi = false,
    this.maxWeeks = 12,
    this.coloredDateTimes = const {},
    this.height = 100,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _InlineCalenderState();
  }

  @override
  Size get preferredSize => Size(100, this.height);
}

class _InlineCalenderState extends State<InlineCalender> {
  Future<void> _dateFormatLoader;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_dateFormatLoader == null) {
      final Locale locale = Localizations.localeOf(context);
      _dateFormatLoader =
          initializeDateFormatting(locale.toLanguageTag(), null);
    }

    return ChangeNotifierProvider(
      create: (context) => InlineCalenderModel(
        defaultSelectedDate: widget.startDate,
        onChange: widget.onChange,
      ),
      child: FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: <Widget>[
                WeekdaysRow(
                  middleDate: widget.startDate,
                ),
                CalenderRow(
                  coloredDates: widget.coloredDateTimes.map((dateTime, color) =>
                      MapEntry(removeTimeFrom(dateTime), color)),
                  middleDate: widget.startDate,
                  isShamsi: widget.isShamsi,
                  maxWeeks: widget.maxWeeks,
                ),
              ],
            );
          } else {
            return Container();
          }
        },
        future: _dateFormatLoader,
      ),
    );
  }
}
