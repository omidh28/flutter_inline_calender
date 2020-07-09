import 'package:flutter/material.dart';
import 'package:inline_calender/src/calender_model.dart';
import 'package:inline_calender/src/utilities.dart';
import 'package:provider/provider.dart';

class DayTile extends StatelessWidget {
  final Function onTap;

  /// The day of the month [1..31].
  final int monthDay;
  final bool isToday;
  final String title;
  final DateTime tileDate;

  const DayTile({
    Key key,
    @required this.onTap,
    @required this.monthDay,
    @required this.tileDate,
    this.isToday = false,
    this.title = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InlineCalenderModel model = Provider.of<InlineCalenderModel>(context);
    bool isSelected = isSameDate(model.selectedDate, tileDate);
    Color dotColor = _getDotColorOf(model.coloredDates, tileDate);
    return Material(
      color: _getBackgroundColor(context, isSelected),
      child: InkWell(
        enableFeedback: true,
        onTap: onTap,
        child: Container(
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 7,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildTile(isSelected, context, dotColor),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTile(
      bool isSelected, BuildContext context, Color dotColor) {
    return <Widget>[
      if (!isSelected && title.isNotEmpty) _buildTitle(title) else Container(),
      if (isSelected)
        _dayLableWithChip(context, isSelected)
      else
        _dayLable(context, isSelected),
      if (!isSelected && dotColor != null)
        _buildSubDot(dotColor)
      else
        Container(),
    ];
  }

  Color _getDotColorOf(Map<DateTime, Color> coloredDates, DateTime date) {
    if (!coloredDates.containsKey(date)) return null;
    return coloredDates[date];
  }

  Padding _buildSubDot(Color color) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: CircleAvatar(
        maxRadius: 3,
        backgroundColor: color,
      ),
    );
  }

  Text _buildTitle(String title) {
    return Text(
      title,
      style: TextStyle(color: Colors.black45),
    );
  }

  Text _dayLable(BuildContext context, bool isSelected) {
    return Text(
      monthDay.toString(),
      style: TextStyle(
        color: _getDayNumberColor(context, isSelected),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );
  }

  CircleAvatar _dayLableWithChip(BuildContext context, bool isSelected) {
    return CircleAvatar(
      child: _dayLable(context, isSelected),
      minRadius: 16,
      maxRadius: 16,
    );
  }

  Color _getBackgroundColor(BuildContext context, bool isSelected) {
    if (isToday && !isSelected) {
      return Theme.of(context).primaryColorLight.withOpacity(0.3);
    }

    return Colors.transparent;
  }

  Color _getDayNumberColor(BuildContext context, bool isSelected) {
    if (isSelected) {
      return Colors.white;
    } else if (isToday) {
      return Theme.of(context).primaryColorDark;
    } else {
      return Colors.black45;
    }
  }
}
