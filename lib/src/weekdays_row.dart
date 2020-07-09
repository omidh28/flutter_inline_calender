import 'package:flutter/material.dart';
import 'package:inline_calender/src/weekday_tile.dart';
import 'package:intl/intl.dart';

class WeekdaysRow extends StatelessWidget {
  final int middleWeekday;
  final Locale locale;

  const WeekdaysRow({
    Key key,
    @required this.middleWeekday,
    @required this.locale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    DateTime middleDate = DateTime.now();
    while (middleDate.weekday != middleWeekday) {
      middleDate = middleDate.add(Duration(days: 1));
    }

    for (int i = 0; i < 7; i++) {
      final String abbrWeekName = DateFormat.E(locale.toLanguageTag()).format(
        middleDate.add(Duration(days: i - 3)),
      );

      tiles.add(WeekdayTile(
        lable: locale.languageCode.startsWith('ar')
            ? abbrWeekName
            : abbrWeekName[0],
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
