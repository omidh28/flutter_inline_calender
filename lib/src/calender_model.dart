import 'package:flutter/material.dart';
import 'package:inline_calender/src/utilities.dart';

class InlineCalenderModel extends ChangeNotifier {
  final Function(DateTime) onChange;

  /// keeps track of the last date which used to build slides
  DateTime lastBuildBaseDate;
  DateTime _selectedDate;
  PageController pageController = PageController();
  Map<DateTime, Color> _coloredDates = {};

  InlineCalenderModel({
    @required DateTime defaultSelectedDate,
    this.onChange,
  }) {
    selectedDate = defaultSelectedDate;
  }

  Map<DateTime, Color> get coloredDates => _coloredDates;

  set coloredDates(Map<DateTime, Color> newColoredDateTimes) {
    final Map<DateTime, Color> newColoredDates = newColoredDateTimes.map(
      (DateTime dateTime, Color color) =>
          MapEntry(removeTimeFrom(dateTime), color),
    );

    _coloredDates = newColoredDates;
    notifyListeners();
  }

  DateTime get selectedDate => _selectedDate;

  set selectedDate(DateTime dateTime) {
    final DateTime date = removeTimeFrom(dateTime);
    _selectedDate = date;
    if (onChange != null) onChange(selectedDate);
    notifyListeners();
  }
}
