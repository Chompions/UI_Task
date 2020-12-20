import 'package:flutter/material.dart';
import 'clock_face.dart';
import 'task_scroll.dart';

class ClockBody extends StatefulWidget {
  @override
  _ClockBodyState createState() => _ClockBodyState();
}

class _ClockBodyState extends State<ClockBody> {
  double _scrollExtent = 0.2;

  @override
  void initState() {
    writeContent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Material(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1abc9c), Color(0xFF3498db)],
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: NotificationListener<DraggableScrollableNotification>(
                onNotification: (notification) {
                  print(notification.extent);
                  setState(() {
                    _scrollExtent = notification.extent;
                  });
                  return true;
                },
                child: TaskScroll(screenHeight: screenHeight, screenWidth: screenWidth),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: SafeArea(
                child: Container(
                  width: screenWidth / (_scrollExtent * 2),
                  padding: EdgeInsets.symmetric(
                      vertical: ((screenHeight * .2) - (_scrollExtent * (screenHeight * .2)) + 20),
                      horizontal: 10),
                  child: ClockFace(),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: FloatingActionButton(
                    hoverElevation: 3,
                    backgroundColor: Color(0xFF3498db),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFF1abc9c), Color(0xFF3498db)],
                        ),
                      ),
                      child: Icon(Icons.add),
                    ),
                    onPressed: () {
                      readContent();
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
