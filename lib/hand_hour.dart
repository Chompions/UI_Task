import 'dart:math';

import 'package:flutter/material.dart';

class HourHandPainter extends CustomPainter {
  int hours;
  int minutes;

  HourHandPainter({this.hours, this.minutes});

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    //memusatkan canvas
    canvas.translate(radius, radius);

    //checks if hour is greater than 12 before calculating rotation
    canvas.rotate(this.hours >= 12
        ? 2 * pi * ((this.hours - 12) / 12 + (this.minutes / 720))
        : 2 * pi * ((this.hours / 12) + (this.minutes / 720)));

    Paint hourHandPaint = Paint()
      ..color = Color(0XFF2c3e50)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    canvas.save();

    Path path = Path()
      ..moveTo(0.0, -radius / 1.3)
      ..lineTo(0.0, radius / 6);

    canvas.drawPath(
      path,
      hourHandPaint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(HourHandPainter oldDelegate) {
    return true;
  }
}
