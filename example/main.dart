import 'package:flutter/material.dart';
import 'package:inline_calender/inline_calender.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  InlineCalenderModel _controller;
  DateTime _pickedDate = DateTime.now();
  Map<DateTime, Color> _coloredDates = {
    DateTime.now().add(Duration(days: 2)): Colors.blue,
    DateTime.now().subtract(Duration(days: 7)): Colors.red,
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _controller.selectedDate =
                _controller.selectedDate.add(Duration(days: 1));
          },
          child: Text('Add a Day'),
        ),
        appBar: AppBar(
          title: Text('Inline Calender'),
          bottom: InlineCalender(
            controller: _controller,
            locale: Locale('en_US'),
            isShamsi: false,
            height: 100,
            maxWeeks: 12,
            middleWeekday: DateTime.now().weekday,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    _controller = InlineCalenderModel(
      defaultSelectedDate: _pickedDate,
      onChange: (DateTime date) => print(date),
    );
    _controller.setColoredDates(_coloredDates);
    super.initState();
  }

  @override
  void dispose() {
    print('dispose');
    _controller.dispose();
    super.dispose();
  }
}
