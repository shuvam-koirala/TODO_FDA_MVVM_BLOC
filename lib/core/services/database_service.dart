import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_fda_mvvm_bloc/features/todo/data/models/todo_model.dart';
import 'package:todo_fda_mvvm_bloc/features/todo/domain/entities/todo.dart';

class DatabaseService {
  DatabaseService._internal();
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() {
    return _instance;
  }

  Database? _db;
  Future<Database> get database async {
    return _db ?? await getDatabase();
  }

  Future<void> init() async {
    _db = await getDatabase();
  }

  final String _tasksTableName = "tasks";
  final String _tasksIdColumnName = "id";
  final String _tasksTitleColumnName = "title";
  final String _tasksStatusColumnName = "status";
  final String _tasksDescriptionColumnName = "description";

  Future<Database> getDatabase() async {
    final String databaseDirPath = await getDatabasesPath();
    final String databasePath = join(databaseDirPath, "todos_db.db");
    final Database database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE $_tasksTableName (
          $_tasksIdColumnName INTEGER PRIMARY KEY,
          $_tasksTitleColumnName TEXT NOT NULL,
          $_tasksDescriptionColumnName TEXT NOT NULL,
          $_tasksStatusColumnName INTEGER NOT NULL
          )
          ''');
      },
    );
    return database;
  }

  void addTask(TodoModel todo) async {
    final Database db = await database;
    await db.insert(_tasksTableName, {
      _tasksTitleColumnName: todo.title,
      _tasksDescriptionColumnName: todo.description,
      _tasksStatusColumnName: todo.isCompleted ? 1 : 0
    });
  }

  Future<int> updateTask(TodoModel todo) async {
    final Database db = await database;
    try {
      final int count = await db.rawUpdate(
          "UPDATE $_tasksTableName SET $_tasksStatusColumnName=? WHERE $_tasksIdColumnName=?",
          [todo.isCompleted ? 1 : 0, todo.id]);
      return count;
    } on Exception catch (e) {
      throw Exception("Unable to update task");
    }
  }

  Future<List<TodoModel>> getTask() async {
    final Database db = await database;
    final List<Map<String, Object?>> data = await db.query(_tasksTableName);
    List<TodoModel> todos = [];
    for (Map<String, Object?> d in data) {
      todos.add(TodoModel(
          id: d[_tasksIdColumnName].toString(),
          description: d[_tasksDescriptionColumnName].toString(),
          title: d[_tasksTitleColumnName].toString(),
          isCompleted: d[_tasksStatusColumnName] == 1));
    }
    return todos;
  }

  Future<int> deleteTask({required String id}) async {
    final Database db = await database;
    try {
      final int count = await db.rawDelete(
          'DELETE FROM $_tasksTableName WHERE $_tasksIdColumnName=?', [id]);
      return count;
    } on Exception catch (e) {
      throw Exception("Unable to delete task");
    }
  }
}
