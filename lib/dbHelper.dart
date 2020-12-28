import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sql_assginment/task.dart';

class DbHelper {
  DbHelper._();
  Database database;
  static DbHelper db = DbHelper._();

  Future<Database> initDatabase() async {
    if (database == null) {
      return await createDatabase();
    } else
      return database;
  }

  Future<Database> createDatabase() async {
    try {
      var dbPath = await getDatabasesPath();
      var path = join(dbPath, "todo.db");
      return await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) {
          db.execute(Task.CREATE_TABLE);
        },
      );
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<int> insertTask(Task task) async {
    database = await initDatabase();
    return await database.insert("${Task.TABLE_NAME}", task.toJson());
  }

  updateTask(int id, Task task) async {
    database = await initDatabase();
    return await database.update(Task.TABLE_NAME, task.toJson(),
        where: '${Task.COL_ID}=?', whereArgs: [id]);
  }

  deleteTask(int id) async {
    database = await initDatabase();
    return await database
        .delete(Task.TABLE_NAME, where: '${Task.COL_ID}=?', whereArgs: [id]);
  }

  Future<List<Task>> getAllTasks() async {
    database = await initDatabase();
    List<Map> result = await database.query(Task.TABLE_NAME);
    return result.map((e) => Task.fromJson(e)).toList();
  }

  Future<List<Task>> getIsFinishedTask(int isFinished) async {
    database = await initDatabase();
    List<Map> result = await database.query(Task.TABLE_NAME,
        where: '${Task.COL_IS_FINISHED}=?', whereArgs: [isFinished]);

    return result.map((e) => Task.fromJson(e)).toList();
  }
}
