import 'package:flutter/material.dart';

class WeekdayTile extends StatelessWidget {
  final String lable;
  final Color color;

  const WeekdayTile({
    Key key,
    @required this.lable,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 7,
      child: Center(
        child: Text(
          lable,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
