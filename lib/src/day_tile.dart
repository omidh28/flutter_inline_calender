import 'package:flutter/material.dart';

class DayTile extends StatelessWidget {
  final Function onTap;

  /// The day of the month [1..31].
  final int monthDay;
  final bool isSelected;
  final bool isToday;
  final String title;
  final Color dotColor;

  const DayTile({
    Key key,
    @required this.onTap,
    @required this.monthDay,
    this.isSelected = false,
    this.isToday = false,
    this.title = '',
    this.dotColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _getBackgroundColor(context),
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
                  isSelected ? _dayLableWithChip(context) : _dayLable(context),
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

  Text _dayLable(BuildContext context) {
    return Text(
      monthDay.toString(),
      style: TextStyle(
        color: _getDayNumberColor(context),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );
  }

  CircleAvatar _dayLableWithChip(BuildContext context) {
    return CircleAvatar(
      child: _dayLable(context),
      minRadius: 16,
      maxRadius: 16,
    );
  }

  Color _getBackgroundColor(BuildContext context) {
    if (isToday && !isSelected) {
      return Theme.of(context).primaryColorLight.withOpacity(0.3);
    }

    return Colors.transparent;
  }

  Color _getDayNumberColor(BuildContext context) {
    if (isSelected) {
      return Colors.white;
    } else if (isToday) {
      return Theme.of(context).primaryColorDark;
    } else {
      return Colors.black45;
    }
  }
}
