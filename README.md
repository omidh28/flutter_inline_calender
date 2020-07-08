# inline_calender

An inline calender package inspired by outlook app. It also supports Jalali/Shamsi calender.

Uses theme and locale of context to localize and change color of widgets.

<img src="https://github.com/omidh28/flutter_inline_calender/blob/master/screenshots/screenshot_01.png?raw=true" height="500">


## Usage

Add the module to your project ``pubspec.yaml`` then install it using ``flutter packages get`


``` yaml
...
dependencies:
 ...
 inline_calender: ^0.0.1
...
```

**Example:**

``` Dart
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
```