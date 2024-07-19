import 'package:todo_fda_mvvm_bloc/features/todo/data/models/todo_model.dart';

abstract class TodoRepository {
  Future<List<TodoModel>> getTodos();
  Future<String> addTodo(TodoModel todo);
  Future<String> deleteTodo(String id);
  Future<String> updateTodo(TodoModel todo);
}
