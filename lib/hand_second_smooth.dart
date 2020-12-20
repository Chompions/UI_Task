import 'dart:async';
import 'dart:math';
// ?This code is broken, do not use

import 'package:flutter/material.dart';

class SecondHandPainterOther extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    // ?centers the canvas
    canvas.translate(radius, radius);

    Paint secondHandPaint = Paint()
      ..color = Color(0XFF2c3e50)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    canvas.save();

    Path path = Path()
      ..moveTo(0.0, -radius / 1.3)
      ..lineTo(0.0, radius / 6);

    canvas.drawPath(path, secondHandPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(SecondHandPainterOther oldDelegate) => false;
}

class SecondHand extends StatefulWidget {
  @override
  _SecondHandState createState() => _SecondHandState();
}

class _SecondHandState extends State<SecondHand> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Timer _timer;
  DateTime dateTime;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
    );
    _animationController.forward();
    dateTime = DateTime.now();
    // timer
    _timer = Timer.periodic(const Duration(seconds: 1), setTime);
  }

  void setTime(Timer timer) {
    setState(() {
      dateTime = DateTime.now();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: AnimatedBuilder(
        animation: _animationController,
        child: CustomPaint(
          painter: SecondHandPainterOther(),
        ),
        builder: (context, _widget) {
          return Transform.rotate(
            angle: 2 * pi * (dateTime.second / 60),
            child: _widget,
          );
        },
      ),
    );
  }
}
