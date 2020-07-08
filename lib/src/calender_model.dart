import 'package:flutter/material.dart';
import 'package:inline_calender/src/days_slide.dart';
import 'package:inline_calender/src/utilities.dart';

class InlineCalenderModel extends ChangeNotifier {
  final Function(DateTime) onChange;

  DateTime _selectedDate;
  Map<DateTime, int> mappedDaysToPages = {};
  List<DaysSlide> recentDaysSlides;

  InlineCalenderModel({
    @required DateTime defaultSelectedDate,
    @required this.onChange,
    Map<DateTime, int> mappedPageDay,
  }) {
    mappedDaysToPages = {};
    _selectedDate = defaultSelectedDate;
  }

  get selectedDate => _selectedDate;

  set selectedDate(DateTime newDate) {
    _selectedDate = newDate;
    this.onChange(newDate);
    notifyListeners();
  }

  void mapDateToPage(DateTime dateTime, int pageNumber) {
    final DateTime date = removeTimeFrom(dateTime);
    mappedDaysToPages[date] = pageNumber;
  }

  void clearDateToPageMap() {
    mappedDaysToPages.clear();
  }

  int getPageNumberOf(DateTime dateTime) {
    final DateTime date = removeTimeFrom(dateTime);
    if (!mappedDaysToPages.containsKey(date)) return null;
    return mappedDaysToPages[date];
  }
}
