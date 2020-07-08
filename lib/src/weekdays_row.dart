import 'package:flutter/material.dart';
import 'package:inline_calender/src/weekday_tile.dart';
import 'package:intl/intl.dart';

class WeekdaysRow extends StatelessWidget {
  final DateTime middleDate;

  const WeekdaysRow({
    Key key,
    @required this.middleDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    return SizedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildWeekdayTiles(locale, context),
      ),
      height: 30,
      width: MediaQuery.of(context).size.width,
    );
  }

  List<Widget> _buildWeekdayTiles(Locale locale, BuildContext context) {
    List<Widget> tiles = [];
    for (int i = 0; i < 7; i++) {
      tiles.add(WeekdayTile(
        lable: DateFormat.E(locale.toLanguageTag()).format(
          middleDate.add(Duration(days: i - 3)),
        )[0],
        color: _getWeekdayNameColor(context),
      ));
    }

    return tiles;
  }

  Color _getWeekdayNameColor(BuildContext context) {
    return Theme.of(context).appBarTheme.brightness == Brightness.dark
        ? Colors.black87
        : Colors.white;
  }
}
