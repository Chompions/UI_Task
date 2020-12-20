import 'dart:math';

import 'package:flutter/material.dart';

class MinuteHandPainter extends CustomPainter {
  int minutes;
  int seconds;

  MinuteHandPainter({this.minutes, this.seconds});

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;

    canvas.translate(radius, radius);

    canvas.rotate(2 * pi * ((this.minutes + (this.seconds / 60)) / 60));

    Paint minuteHandPaint = Paint()
      ..color = Color(0XFF7f8c8d)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0;

    canvas.save();

    Path path = Path()
      ..moveTo(0.0, -radius / 1.3)
      ..lineTo(0.0, radius / 6);

    canvas.drawPath(
      path,
      minuteHandPaint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(MinuteHandPainter oldDelegate) {
    return true;
  }
}
