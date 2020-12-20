import 'package:flutter/material.dart';
import 'clock_dial_painter.dart';
import 'clock_hands.dart';

class ClockFace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Stack(
          children: [
            Center(
              child: Container(
                width: 350,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0XFFecf0f1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.2),
                      spreadRadius: 3,
                      blurRadius: 2,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                width: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0XFFecf0f1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.2),
                      spreadRadius: 8,
                      blurRadius: 5,
                      offset: Offset(2, 3),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 350,
              padding: EdgeInsets.all(10),
              child: CustomPaint(
                painter: ClockDialPainter(),
              ),
            ),
            Center(
              child: ClockHands(),
            ),
            Center(
              child: Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
