part of 'todo_bloc.dart';

enum TodoListStatus {
  loading,
  adding,
  updating,
  deleting,
  loaded,
  added,
  updated,
  deleted,
  errorLoading,
  errorAdding,
  errorUpdating,
  errorDeleting
}

class TodoState extends Equatable {
  const TodoState(
      {this.todos = const [],
      this.status = TodoListStatus.loading,
      this.message = ""});
  final List<Todo> todos;
  final TodoListStatus status;
  final String message;

  TodoState copyWith(
      {List<Todo>? todos, TodoListStatus? status, String? message}) {
    return TodoState(
        status: status ?? this.status,
        todos: todos ?? this.todos,
        message: message ?? this.message);
  }

  @override
  List<Object> get props => [todos, status];
}

// final class TodoInitial extends TodoState {
//   const TodoInitial({required super.todos});
// }

// final class TodoFetching extends TodoState {
//   const TodoFetching({required super.todos});
// }

// final class TodoFetchingError extends TodoState {
//   final String message;
//   const TodoFetchingError({required this.message, required super.todos});
//   @override
//   List<Object> get props => [message, super.todos];
// }

// final class TodoFetched extends TodoState {
//   final String message;
//   const TodoFetched({required this.message, required super.todos});
//   @override
//   List<Object> get props => [message, super.todos];
// }

// final class TodoAdding extends TodoState {
//   const TodoAdding({required super.todos});
// }

// final class TodoAddingError extends TodoState {
//   final String message;
//   const TodoAddingError({required this.message, required super.todos});
//   @override
//   List<Object> get props => [message, super.todos];
// }

// final class TodoAdded extends TodoState {
//   final String message;
//   const TodoAdded({required this.message, required super.todos});
//   @override
//   List<Object> get props => [message, super.todos];
// }

// final class TodoRemoving extends TodoState {
//   const TodoRemoving({required super.todos});
// }

// final class TodoRemovingError extends TodoState {
//   final String message;
//   const TodoRemovingError({required this.message, required super.todos});
//   @override
//   List<Object> get props => [message, super.props];
// }

// final class TodoRemoved extends TodoState {
//   final String message;
//   const TodoRemoved({required this.message, required super.todos});
//   @override
//   List<Object> get props => [message, super.props];
// }

// final class TodoUpdating extends TodoState {
//   const TodoUpdating({required super.todos});
// }

// final class TodoUpdatingError extends TodoState {
//   final String message;
//   const TodoUpdatingError({required this.message, required super.todos});
//   @override
//   List<Object> get props => [message, super.props];
// }

// final class TodoUpdated extends TodoState {
//   final String message;
//   const TodoUpdated({required this.message, required super.todos});
//   @override
//   List<Object> get props => [message, super.props];
// }
