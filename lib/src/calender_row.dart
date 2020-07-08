import 'package:carousel_extended/carousel_extended.dart';
import 'package:flutter/material.dart';
import 'package:inline_calender/src/days_row.dart';

class CalenderRow extends StatelessWidget {
  final DateTime middleDate;
  final bool isShamsi;
  final int maxWeeks;
  final Map<DateTime, Color> coloredDates;

  const CalenderRow({
    Key key,
    @required this.middleDate,
    @required this.isShamsi,
    @required this.maxWeeks,
    @required this.coloredDates,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => controller.jumpToPage(maxWeeks));
    return SizedBox(
      height: MediaQuery.of(context).size.width / 7,
      width: MediaQuery.of(context).size.width,
      child: Container(
        color: Colors.white,
        child: Carousel(
          pageController: controller,
          showIndicator: false,
          autoplay: false,
          images: _buildDaysRows(),
        ),
      ),
    );
  }

  List<DaysRow> _buildDaysRows() {
    List<DaysRow> rows = [];
    final DateTime startWeekMiddleDate =
        middleDate.subtract(Duration(days: (7 * maxWeeks)));
    for (int i = 0; i < maxWeeks * 2; i++) {
      rows.add(
        DaysRow(
          middleDate: startWeekMiddleDate.add(Duration(days: (i * 7))),
          isShamsi: isShamsi,
          coloredDates: coloredDates,
        ),
      );
    }

    return rows;
  }
}
