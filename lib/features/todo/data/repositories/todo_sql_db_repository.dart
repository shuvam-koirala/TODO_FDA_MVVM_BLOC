import 'package:todo_fda_mvvm_bloc/core/services/database_service.dart';
import 'package:todo_fda_mvvm_bloc/features/todo/data/models/todo_model.dart';
import 'package:todo_fda_mvvm_bloc/features/todo/data/repositories/todo_repository.dart';

class TodoSqlDbRepository implements TodoRepository {
  final DatabaseService _databaseService = DatabaseService();
  @override
  Future<String> addTodo(TodoModel todo) async {
    try {
      _databaseService.addTask(todo);
      return "Task Added";
    } on Exception catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> deleteTodo(String id) async {
    try {
      final int count = await _databaseService.deleteTask(id: id);
      return "$count Task Deleted";
    } on Exception catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<TodoModel>> getTodos() async {
    try {
      return await _databaseService.getTask();
    } on Exception catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> updateTodo(TodoModel todo) async {
    try {
      final int count = await _databaseService.updateTask(todo);
      return "$count Task Updated";
    } on Exception catch (e) {
      rethrow;
    }
  }
}
