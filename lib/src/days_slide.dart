import 'package:flutter/material.dart';
import 'package:inline_calender/src/calender_model.dart';
import 'package:inline_calender/src/day_tile.dart';
import 'package:inline_calender/src/utilities.dart';
import 'package:intl/intl.dart';
import 'package:shamsi_date/shamsi_date.dart';

class DaysSlide extends StatelessWidget {
  final DateTime middleDate;
  final bool isShamsi;
  final int pageNumber;
  final Locale locale;
  final InlineCalenderModel model;

  DaysSlide({
    Key key,
    @required this.middleDate,
    @required this.isShamsi,
    @required this.pageNumber,
    @required this.locale,
    @required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildDayTiles(model, locale),
    );
  }

  List<DayTile> _buildDayTiles(InlineCalenderModel model, Locale locale) {
    List<DayTile> tiles = [];
    for (int i = 0; i < 7; i++) {
      final DateTime dateTime = middleDate.add(Duration(days: i - 3));
      final Jalali shamsiDate = Jalali.fromDateTime(dateTime);
      final String gregorianMonthLable =
          DateFormat.MMM(locale.toLanguageTag()).format(dateTime);
      final String shamsiMonthLable = shamsiDate.formatter.mN;
      final String monthLable =
          isShamsi ? shamsiMonthLable : gregorianMonthLable;
      final int dayOfMonth = isShamsi ? shamsiDate.day : dateTime.day;
      final bool isFirstDayOfMonth = dayOfMonth == 1;
      final DayTile tile = DayTile(
        onTap: () => model.selectedDate = dateTime,
        monthDay: dayOfMonth,
        isToday: isSameDate(dateTime, DateTime.now()),
        tileDate: removeTimeFrom(dateTime),
        title: isFirstDayOfMonth ? monthLable : '',
      );

      tiles.add(tile);
    }

    return tiles;
  }
}
