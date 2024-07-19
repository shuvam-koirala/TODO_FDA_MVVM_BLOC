import 'package:todo_fda_mvvm_bloc/features/todo/data/models/todo_model.dart';
import 'package:todo_fda_mvvm_bloc/features/todo/data/repositories/todo_repository.dart';

class TodoHttpRepository implements TodoRepository {
  @override
  Future<List<TodoModel>> getTodos() async {
    Future.delayed(const Duration(seconds: 10));
    return List.generate(
        10,
        (int index) => TodoModel(
            description: "description for title$index",
            id: index.toString(),
            title: "title $index",
            isCompleted: false));
    // throw DioException(requestOptions: RequestOptions());
  }

  @override
  Future<String> deleteTodo(String id) async {
    Future.delayed(const Duration(seconds: 10));
    return "Todo Deleted";
    // throw DioException(requestOptions: RequestOptions());
  }

  @override
  Future<String> updateTodo(TodoModel todo) async {
    Future.delayed(const Duration(seconds: 10));
    return "Todo Updated";
    // throw DioException(requestOptions: RequestOptions());
  }

  @override
  Future<String> addTodo(TodoModel todo) async {
    Future.delayed(const Duration(seconds: 10));
    return "Todo Added";
    // throw DioException(requestOptions: RequestOptions());
  }
}
