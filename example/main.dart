import 'package:flutter/material.dart';
import 'package:inline_calender/inline_calender.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Inline Calender'),
          bottom: InlineCalender(
            startDate: DateTime.now(),
            onChange: (DateTime date) => print(date),
            isShamsi: false,
            height: 100,
            coloredDateTimes: {
              DateTime.now().add(Duration(days: 2)): Colors.blue,
              DateTime.now().subtract(Duration(days: 7)): Colors.red,
            },
          ),
        ),
      ),
    );
  }
}
