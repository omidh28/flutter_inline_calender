import 'package:flutter/material.dart';
import 'package:inline_calender/src/calender_model.dart';
import 'package:inline_calender/src/day_tile.dart';
import 'package:inline_calender/src/utilities.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shamsi_date/shamsi_date.dart';

class DaysRow extends StatelessWidget {
  final DateTime middleDate;
  final bool isShamsi;
  final Map<DateTime, Color> coloredDates;

  const DaysRow({
    Key key,
    @required this.middleDate,
    @required this.isShamsi,
    @required this.coloredDates,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InlineCalenderModel model = Provider.of<InlineCalenderModel>(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildDayTiles(model, Localizations.localeOf(context)),
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
        isSelected: isSameDate(date, model.selectedDate),
        title: isFirstDayOfMonth ? monthLable : '',
        dotColor: _getDotColorOf(date),
      );

      tiles.add(tile);
    }

    return tiles;
  }

  Color _getDotColorOf(DateTime dateTime) {
    final DateTime date = removeTimeFrom(dateTime);
    if (!coloredDates.containsKey(date)) return null;
    return coloredDates[date];
  }
}
