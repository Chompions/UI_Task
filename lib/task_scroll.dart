import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

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
  List items = ['Hello', 'Hey', "hey there"];
  List icons = ['f204', 'f204', 'f204'];

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
            child: ListView.builder(
              controller: scrollController,
              itemCount: 3,
              itemBuilder: (context, index) {
                return TaskList(
                  index: index,
                  items: items,
                  icons: icons,
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
  final List items;
  final int index;
  final List icons;

  TaskList({
    this.index,
    @required this.items,
    @required this.icons,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${items[index]}'),
      trailing: Icon(
        IconData(
          int.parse('0x${icons[index]}'),
          fontFamily: 'MaterialIcons-Regular',
        ),
      ),
    );
  }
}

class Task {
  String id;
  String taskName;
  String information;
  String icon;
  String hourTime;
  String minuteTime;

  Task({this.id, this.taskName, this.information, this.icon, this.hourTime, this.minuteTime});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        id: json["id"],
        taskName: json["taskName"],
        information: json["information"],
        icon: json["icon"],
        hourTime: json["hourTime"],
        minuteTime: json["minuteTime"]);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "taskName": taskName,
        "information": information,
        "icon": icon,
        "hourTime": hourTime,
        "minuteTime": minuteTime,
      };

  @override
  String toString() {
    return '"task" : {"id": $id, "taskName": $taskName, "information": $information, "icon": $icon, "hourTime": $hourTime, "minuteTime": $minuteTime}';
  }
}

Future<String> get _localPath async {
  final docDir = await getApplicationDocumentsDirectory();
  print(docDir.path);
  return docDir.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/sample.json');
}

Future<File> writeContent() async {
  final file = await _localFile;
  return file.writeAsString(
      '{"id": "1","taskName": "Cook","information": "Make something good","icon": "f204","hourTime": "23","minuteTime": "10"}');
}

Future readContent() async {
  try {
    final file = await _localFile;
    String jsonString = await file.readAsString();
    print('jsonString = $jsonString');
    final jsonData = json.decode(jsonString);
    Task taskSample = Task.fromJson(jsonData);
    print('taskSample = ${taskSample.toString()}');
  } catch (e) {
    print(e);
  }
}

// class User {
//   Task task;

//   User({this.task});

//   User.fromJson(Map<String, dynamic> json) {
//     task = json['task'] != null ? Task.fromJson(json['task']) : null;
//     token = json['token'];
//   }

//   Map<String, dynamic> toJson() {
//     final data = Map<String, dynamic>();
//     if (this.task != null) {
//       data['task'] = this.task.toJson();
//     }
//     data['token'] = this.token;
//     return data;
//   }

//   @override
//   String toString() {
//     return '"user" : {${task.toString()}, "token": $token}';
//   }
// }

// Future<void> saveTask() async {
//   final String firstTask = SharedPreferences.setMockInitialValues({});
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   bool result = await prefs.setString('user', jsonEncode(user));
//   print(result);
// }

// Future<void> saveTask() async {
//   final Task firstTask = Task.fromJson(
//     {
//       'id': '1',
//       'taskName': 'Cook',
//       'information': 'Make something good',
//       'icon': 'f204',
//       'hourTime': '23',
//       'minuteTime': '10'
//     },
//   );

//   SharedPreferences.setMockInitialValues({});
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   bool result = await prefs.setString('user', jsonEncode(user));
//   print(result);
// }

// Future<User> getUserTask() async {
//   SharedPreferences.setMockInitialValues({});
//   final prefs = await SharedPreferences.getInstance();

//   String userStr = prefs.getString('user');
//   print(userStr);

// Map<String, dynamic> userMap;
// String userStr = prefs.getString('user');
// if (userStr != null) {
//   userMap = jsonDecode(userStr) as Map<String, dynamic>;
//   print(userStr);
// }

// if (userMap != null) {
//   User user = User.fromJson(userMap);
//   print(user);
//   return user;
// }
// return null;
