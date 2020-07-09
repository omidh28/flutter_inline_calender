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
  final DateTime pickedDate;

  const DayTile({
    Key key,
    @required this.onTap,
    @required this.monthDay,
    @required this.pickedDate,
    this.isToday = false,
    this.title = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InlineCalenderModel model = Provider.of<InlineCalenderModel>(context);
    bool isSelected = isSameDate(model.selectedDate, pickedDate);
    Color dotColor = _getDotColorOf(model, pickedDate);
    return Material(
      color: _getBackgroundColor(context,isSelected),
      child: InkWell(
        enableFeedback: true,
        onTap: onTap,
        child: Container(
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 7,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  !isSelected && title.isNotEmpty
                      ? _buildTitle(title)
                      : Container(),
                  isSelected ? _dayLableWithChip(context,isSelected) : _dayLable(context,isSelected),
                  !isSelected && dotColor != null
                      ? _buildSubDot(dotColor)
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  Color _getDotColorOf(InlineCalenderModel model, DateTime dateTime) {
    print('getting color of ${dateTime.toString()}');
    final DateTime date = removeTimeFrom(dateTime);
    if (!model.coloredDates.containsKey(date)) return null;
    return model.coloredDates[date];
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
