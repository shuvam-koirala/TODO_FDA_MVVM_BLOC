import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_fda_mvvm_bloc/features/todo/domain/entities/todo.dart';
import 'package:todo_fda_mvvm_bloc/features/todo/domain/usecases/todo_usecase.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoUsecase _usecase;
  List<Todo> todos = [];
  TodoBloc(this._usecase) : super(const TodoState()) {
    on<GetTodos>((event, emit) async {
      try {
        todos = await _usecase.getTodos();
        emit(state.copyWith(
            todos: List.from(todos), status: TodoListStatus.success));
      } on Exception catch (e) {
        emit(state.copyWith(status: TodoListStatus.error));
      }
    });
    on<AddTodo>((event, emit) async {
      try {
        await _usecase.addTodo(event.todo);
        todos.add(event.todo);
        emit(state.copyWith(
            todos: List.from(todos), status: TodoListStatus.success));
      } on Exception catch (e) {
        emit(state.copyWith(status: TodoListStatus.error));
      }
    });
    on<UpdateTodo>((event, emit) async {
      String? message = await _usecase.updateTodo(event.todo);
    });
    on<RemoveTodo>((event, emit) async {
      String? message = await _usecase.deleteTodo(event.todo.id);
    });
  }
}
