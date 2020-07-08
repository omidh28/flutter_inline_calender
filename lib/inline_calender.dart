library inline_calender;

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:inline_calender/src/calender_model.dart';
import 'package:inline_calender/src/calender_row.dart';
import 'package:inline_calender/src/utilities.dart';
import 'package:inline_calender/src/weekdays_row.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

class InlineCalender extends StatefulWidget implements PreferredSizeWidget {
  /// picked date
  final DateTime pickedDate;

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

  /// locale used to translate month and weekdays
  final Locale locale;

  const InlineCalender({
    Key key,
    @required this.onChange,
    @required this.pickedDate,
    @required this.locale,
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
    _dateFormatLoader = initializeDateFormatting(
      widget.locale.toLanguageTag(),
      null,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider0(
      create: (context) => InlineCalenderModel(
        defaultSelectedDate: widget.pickedDate,
        onChange: widget.onChange,
      ),
      update: (BuildContext contenxt, InlineCalenderModel value) {
        if (value.selectedDate == widget.pickedDate) return value;

        WidgetsBinding.instance.addPostFrameCallback((_) {
          return value.selectedDate = widget.pickedDate;
        });

        return value;
      },
      child: FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: <Widget>[
                WeekdaysRow(middleDate: DateTime.now()),
                CalenderRow(
                  isShamsi: widget.isShamsi,
                  maxWeeks: widget.maxWeeks,
                  coloredDates: widget.coloredDateTimes.map((dateTime, color) =>
                      MapEntry(removeTimeFrom(dateTime), color)),
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
