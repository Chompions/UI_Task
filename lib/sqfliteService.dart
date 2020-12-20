import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Task {
  String id;
  String taskName;
  String information;
  String icon;
  String hourTime;
  String minuteTime;

  Task({this.id, this.taskName, this.information, this.icon, this.hourTime, this.minuteTime});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "taskName": taskName,
      "information": information,
      "icon": icon,
      "hourTime": hourTime,
      "minuteTime": minuteTime,
    };
  }
}

class SQFLiteService {
  Future<Database> getDatabase() async {
    String path = join(
      await getDatabasesPath(),
      'Tasks.db',
    );
    Database db = await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE tasks(id TEXT PRIMARY KEY, taskName TEXT, information TEXT, icon TEXT, hourTime TEXT, minuteTime TEXT)",
        );
      },
      version: 1,
    );
    return db;
  }

  Future<void> addTask(Task task) async {
    Database db = await getDatabase();
    await db.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List> getTasks() async {
    Database db = await getDatabase();

    final List<Map<String, dynamic>> maps = await db.query('tasks');

    return List.generate(maps.length, (i) {
      var result = Task(
        id: maps[i]['id'],
        taskName: maps[i]['taskName'],
        information: maps[i]['information'],
        icon: maps[i]['icon'],
        hourTime: maps[i]['hourTime'],
        minuteTime: maps[i]['minuteTime'],
      );
      return result.toMap();
    });
  }
}
