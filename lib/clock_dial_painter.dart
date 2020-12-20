import 'dart:math';
import 'package:flutter/material.dart';

class ClockDialPainter extends CustomPainter {
  final hourTickMarkLength = 10;
  final minuteTickMarkLength = 5;

  final hourTickMarkWidth = 3;
  final minuteTickMarkWidth = 1.5;

  final Paint tickPaint;
  final TextPainter textPainter;
  final TextStyle textStyle;

  ClockDialPainter()
      : tickPaint = Paint(),
        textPainter = TextPainter(
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
        ),
        textStyle = TextStyle(
          color: Colors.black,
          fontSize: 15,
        ) {
    tickPaint.color = Colors.blueGrey;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var tickMarkLength;
    final angle = 2 * pi / 60;
    final radius = size.width / 2;
    canvas.save();

    //drawing
    canvas.translate(radius, radius);
    for (var i = 0; i < 60; i++) {
      tickMarkLength = i % 5 == 0 ? hourTickMarkLength : minuteTickMarkLength;
      tickPaint.strokeWidth = 1 % 5 == 0 ? hourTickMarkLength : minuteTickMarkWidth;

      canvas.drawLine(Offset(0, -radius), Offset(0, -radius + tickMarkLength), tickPaint);

      //draw the text
      if (i % 5 == 0) {
        canvas.save();
        canvas.translate(0, -radius + 20);

        textPainter.text = TextSpan(
          text: '${i == 0 ? 12 : i ~/ 5}',
          style: textStyle,
        );

        //helps make the text painted vertically
        canvas.rotate(-angle * i);
        textPainter.layout();
        textPainter.paint(canvas, Offset(-(textPainter.width / 2), -(textPainter.height / 2)));

        canvas.restore();
      }

      canvas.rotate(angle);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
