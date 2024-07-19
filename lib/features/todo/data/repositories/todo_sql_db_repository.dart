import 'package:todo_fda_mvvm_bloc/core/services/database_service.dart';
import 'package:todo_fda_mvvm_bloc/features/todo/data/models/todo_model.dart';
import 'package:todo_fda_mvvm_bloc/features/todo/data/repositories/todo_repository.dart';

class TodoSqlDbRepository implements TodoRepository {
  final DatabaseService _databaseService = DatabaseService();
  @override
  Future<String> addTodo(TodoModel todo) async {
    _databaseService.addTask(todo);
    return "Todo Added";
  }

  @override
  Future<String> deleteTodo(String id) {
    // TODO: implement deleteTodo
    throw UnimplementedError();
  }

  @override
  Future<List<TodoModel>> getTodos() async {
    return await _databaseService.getTask();
  }

  @override
  Future<String> updateTodo(TodoModel todo) {
    // TODO: implement updateTodo
    throw UnimplementedError();
  }
}
