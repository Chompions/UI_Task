import 'package:flutter/material.dart';
import 'sqfliteService.dart';

class TaskScroll extends StatefulWidget {
  TaskScroll({
    @required this.screenHeight,
    @required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  _TaskScrollState createState() => _TaskScrollState();
}

class _TaskScrollState extends State<TaskScroll> {
  final SQFLiteService sql = SQFLiteService();

  final firstSampleTask = Task(
      id: "1",
      taskName: "Cook",
      information: "Make something good",
      icon: "59607",
      hourTime: "23",
      minuteTime: "10");

  final secondSampleTask = Task(
      id: "2",
      taskName: "Run",
      information: "Be healthy",
      icon: "58333",
      hourTime: "07",
      minuteTime: "15");

  void addSampelTask() async {
    sql..addTask(firstSampleTask)..addTask(secondSampleTask);
    print(await sql.getTasks());
  }

  @override
  void initState() {
    addSampelTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.screenHeight * .8,
      child: DraggableScrollableSheet(
        initialChildSize: 0.2,
        minChildSize: 0.2,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Color(0XFFecf0f1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 20,
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: FutureBuilder(
              future: sql.getTasks(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.none || snapshot.hasData == null) {
                  print('Snapshot data is ${snapshot.data}');
                }
                return ListView.builder(
                  controller: scrollController,
                  itemCount: snapshot.data == null ? 0 : snapshot.data.length,
                  itemBuilder: (context, index) {
                    return TaskList(snapshot.data[index]);
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class TaskList extends StatelessWidget {
  final Map<String, dynamic> tasksMap;

  TaskList(this.tasksMap);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(tasksMap["taskName"]),
      subtitle:
          Text('${tasksMap["information"]} on ${tasksMap["hourTime"]}:${tasksMap["minuteTime"]}'),
      trailing: Icon(
        IconData(
          int.parse(tasksMap["icon"]),
          fontFamily: 'MaterialIcons',
        ),
        color: Colors.blue,
      ),
    );
  }
}
