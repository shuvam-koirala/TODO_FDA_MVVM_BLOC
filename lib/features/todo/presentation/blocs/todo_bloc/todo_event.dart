part of 'todo_bloc.dart';

sealed class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class GetTodos extends TodoEvent {
  @override
  List<Object> get props => [];
}

class AddTodo extends TodoEvent {
  final Todo todo;
  const AddTodo({required this.todo}) : super();
  @override
  List<Object> get props => [];
}

class RemoveTodo extends TodoEvent {
  final Todo todo;
  const RemoveTodo({required this.todo}) : super();
  @override
  List<Object> get props => [];
}

class UpdateTodo extends TodoEvent {
  final Todo todo;
  const UpdateTodo({required this.todo}) : super();
  @override
  List<Object> get props => [];
}
