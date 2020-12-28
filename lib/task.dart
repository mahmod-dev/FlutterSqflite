import 'package:flutter/cupertino.dart';

class Task extends ChangeNotifier {
  static const TABLE_NAME = "task_tb";
  static const COL_ID = "id";
  static const COL_TITLE = "title";
  static const COL_IS_FINISHED = "is_finished";
  static const CREATE_TABLE = '''CREATE TABLE $TABLE_NAME(
      $COL_ID INTEGER PRIMARY KEY AUTOINCREMENT,
      $COL_TITLE TEXT, 
      $COL_IS_FINISHED INTEGER)''';

  String title;
  int isFinished; // 0 notFinished, 1 finished
  int id;
  List<Task> list;
  Task();

  List<Task> getList() {
    return this.list;
  }

  setList(List<Task> list) {
    this.list = list;
    notifyListeners();
  }

  setValue(var title, var isFinished) {
    this.title = title;
    this.isFinished = isFinished;
  }

  toJson() {
    notifyListeners();

    return {
      COL_TITLE: this.title,
      COL_IS_FINISHED: this.isFinished,
    };
  }

  Task.fromJson(Map map) {
    this.title = map[COL_TITLE];
    this.isFinished = map[COL_IS_FINISHED];
    this.id = map[COL_ID];
  }
}
