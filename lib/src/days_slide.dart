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
  List<DayTile> dayTiles;

  DaysSlide({
    Key key,
    @required this.middleDate,
    @required this.isShamsi,
    @required this.pageNumber,
    @required this.locale,
    @required this.model,
  }) : super(key: key) {
    this.dayTiles = _buildDayTiles(model, locale);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: dayTiles,
    );
  }

  List<DayTile> _buildDayTiles(InlineCalenderModel model, Locale locale) {
    List<DayTile> tiles = [];
    for (int i = 0; i < 7; i++) {
      final DateTime date = middleDate.add(Duration(days: i - 3));
      final Jalali shamsiDate = Jalali.fromDateTime(date);
      final String gregorianMonthLable =
          DateFormat.MMM(locale.toLanguageTag()).format(date);
      final String shamsiMonthLable = shamsiDate.formatter.mN;
      final String monthLable =
          isShamsi ? shamsiMonthLable : gregorianMonthLable;
      final int dayOfMonth = isShamsi ? shamsiDate.day : date.day;
      final bool isFirstDayOfMonth = dayOfMonth == 1;
      final DayTile tile = DayTile(
        onTap: () => model.selectedDate = date,
        monthDay: dayOfMonth,
        isToday: isSameDate(date, DateTime.now()),
        pickedDate: date,
        title: isFirstDayOfMonth ? monthLable : '',
      );

      tiles.add(tile);
      model.mapDateToPage(date, pageNumber);
    }

    return tiles;
  }
}
