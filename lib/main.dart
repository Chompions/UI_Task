import 'package:flutter/material.dart';
import 'clock_body.dart';

void main() => runApp(UITask());

class UITask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clock',
      theme: ThemeData(
        fontFamily: 'OpenSans',
      ),
      home: ClockBody(),
    );
  }
}
