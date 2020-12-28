class Task {
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

  Task(this.title, this.isFinished);

  toJson() {
    return {
      COL_TITLE: this.title,
      COL_IS_FINISHED: this.isFinished,
    };
  }

  Task.fromJson(Map map) {
    this.title = map[COL_TITLE];
    this.isFinished = map[COL_IS_FINISHED];
  }
}
