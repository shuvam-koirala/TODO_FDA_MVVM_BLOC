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
            todos: List.from(todos), status: TodoListStatus.loaded));
      } on Exception catch (e) {
        emit(state.copyWith(status: TodoListStatus.errorLoading));
      }
    });
    on<AddTodo>((event, emit) async {
      try {
        await _usecase.addTodo(event.todo);

        emit(state.copyWith(
            status: TodoListStatus.added, message: "New Task Added."));
      } on Exception catch (e) {
        emit(state.copyWith(
            status: TodoListStatus.errorAdding, message: e.toString()));
      }
    });
    on<UpdateTodo>((event, emit) async {
      try {
        final String message = await _usecase.updateTodo(event.todo);
        emit(state.copyWith(status: TodoListStatus.updated, message: message));
      } on Exception catch (e) {
        emit(state.copyWith(
            status: TodoListStatus.errorUpdating, message: e.toString()));
      }
    });
    on<RemoveTodo>((event, emit) async {
      try {
        final String message = await _usecase.deleteTodo(event.todo.id);
        emit(state.copyWith(status: TodoListStatus.deleted, message: message));
      } on Exception catch (e) {
        emit(state.copyWith(
            status: TodoListStatus.errorDeleting, message: e.toString()));
      }
    });
  }
}
