import 'dart:ffi';

import 'package:todo_fda_mvvm_bloc/features/todo/data/models/todo_model.dart';
import 'package:todo_fda_mvvm_bloc/features/todo/data/repositories/todo_repository.dart';
import 'package:todo_fda_mvvm_bloc/features/todo/domain/entities/todo.dart';

class TodoUsecase {
  final TodoRepository _repository;
  TodoUsecase(this._repository);
  Future<List<Todo>> getTodos() async {
    final todos = await _repository.getTodos();
    return todos
        .map((todoModel) => Todo(
            id: todoModel.id,
            description: todoModel.description,
            title: todoModel.title,
            isCompleted: todoModel.isCompleted))
        .toList();
  }

  addTodo(Todo todo) async {
    TodoModel todoModel = TodoModel(
        description: todo.description,
        id: todo.id,
        title: todo.title,
        isCompleted: todo.isCompleted);
    await _repository.addTodo(todoModel);
  }

  Future<String> updateTodo(Todo todo) async {
    TodoModel todoModel = TodoModel(
        description: todo.description,
        id: todo.id,
        title: todo.title,
        isCompleted: todo.isCompleted);
    try {
      final String message = await _repository.updateTodo(todoModel);
      return message;
    } on Exception catch (e) {
      rethrow;
    }
  }

  Future<String> deleteTodo(String id) async {
    try {
      final String message = await _repository.deleteTodo(id);
      return message;
    } on Exception catch (e) {
      rethrow;
    }
  }
}
