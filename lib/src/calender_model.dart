import 'package:flutter/material.dart';

class InlineCalenderModel extends ChangeNotifier {
  final Function(DateTime) onChange;

  DateTime _selectedDate;

  InlineCalenderModel({
    @required DateTime defaultSelectedDate,
    @required this.onChange,
  }) {
    _selectedDate = defaultSelectedDate;
  }

  get selectedDate => _selectedDate;

  set selectedDate(DateTime newDate) {
    _selectedDate = newDate;
    this.onChange(DateTime(newDate.year, newDate.month, newDate.day));
    notifyListeners();
  }
}
