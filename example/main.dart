import 'package:flutter/material.dart';
import 'package:inline_calender/inline_calender.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
        floatingActionButton: FloatingActionButton(onPressed: () {
          setState(() {
            _pickedDate = _pickedDate.add(Duration(days: 1));
            _coloredDates = {};
          });
        }),
        appBar: AppBar(
          title: Text('Inline Calender'),
          bottom: InlineCalender(
            locale: Locale('en_US'),
            pickedDate: _pickedDate,
            onChange: (DateTime date) => print(date),
            isShamsi: false,
            height: 100,
            maxWeeks: 12,
            coloredDateTimes: _coloredDates,
          ),
        ),
      ),
    );
  }
}
