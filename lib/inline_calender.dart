library inline_calender;

import 'package:flutter/material.dart';
import 'package:inline_calender/src/calender_model.dart';
import 'package:inline_calender/src/calender_row.dart';
import 'package:inline_calender/src/weekdays_row.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

export 'package:inline_calender/src/calender_model.dart';

class InlineCalender extends StatelessWidget implements PreferredSizeWidget {
  /// Set true to use shamsi/jalali date
  final bool isShamsi;

  /// Number of week available from both ends of start day
  final int maxWeeks;

  /// set the total height of app bar
  final double height;

  /// locale used to translate month and weekdays
  final Locale locale;

  /// controller if you want to change selected date programitcaly
  final InlineCalenderModel controller;

  /// week day of the center of calender slide, default is today's weekdad. [1..7]
  final int middleWeekday;

  final Future<void> dateFormatLoader;

  InlineCalender({
    @required this.locale,
    @required this.controller,
    @required this.middleWeekday,
    this.isShamsi = false,
    this.maxWeeks = 12,
    this.height = 100,
  }) : dateFormatLoader =
            initializeDateFormatting(locale.toLanguageTag(), null) {
    if (maxWeeks % 2 != 0) {
      throw ArgumentError.value(maxWeeks);
    }
  }

  @override
  Size get preferredSize => Size(100, this.height);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: this.controller,
      child: Column(
        children: <Widget>[
          WeekdaysRow(
            middleWeekday: middleWeekday,
            locale: locale,
          ),
          CalenderRow(
            locale: locale,
            isShamsi: isShamsi,
            maxWeeks: maxWeeks,
            middleWeekday: middleWeekday,
          ),
        ],
      ),
    );
  }
}
