import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

class SecondHandPainter extends CustomPainter {
  int seconds;
  SecondHandPainter({this.seconds});

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;

    Paint secondHandPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFd35400), Color(0xFFf1c40f)],
      ).createShader(
        Rect.fromCircle(
          center: Offset(0.0, -radius),
          radius: size.width,
        ),
      )
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    Paint secondHandPointsPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    canvas.save();

    canvas.translate(radius, radius);
    canvas.rotate(2 * pi * (this.seconds / 60));

    Path path1 = Path()
      ..moveTo(0.0, -radius)
      ..lineTo(0.0, radius / 6);
    Path path2 = Path()
      ..addOval(
        Rect.fromCircle(
          radius: 6.0,
          center: Offset(0.0, -radius),
        ),
      );

    canvas
      ..drawShadow(
        path2,
        Colors.grey,
        2,
        false,
      )
      ..drawPath(
        path1,
        secondHandPaint,
      )
      ..drawPath(
        path2,
        secondHandPointsPaint,
      );

    canvas.restore();
  }

  @override
  bool shouldRepaint(SecondHandPainter oldDelegate) {
    return true;
  }
}
