part of "todo_page.dart";

mixin TodoPageModel {
  addTodo(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    final String todoCount =
        context.read<TodoBloc>().state.todos.length.toString();
    final Todo todo = Todo(
        id: todoCount,
        description: "Complete this task",
        title: "Task $todoCount",
        isCompleted: false);
    context.read<TodoBloc>().add(AddTodo(todo: todo));
  }

  changeTheme(BuildContext context) {
    context.read<ThemeChangerCubit>().changeTheme(
        brightness: context.read<ThemeChangerCubit>().state.brightness ==
                Brightness.light
            ? Brightness.dark
            : Brightness.light);
  }

  changeLanguage(BuildContext context) {
    context.read<LocalizationBloc>().add(ChangeLanguage(
        languageCode:
            context.read<LocalizationBloc>().state.locale.languageCode == "en"
                ? "ne"
                : "en"));
  }

  toogleCompletion(BuildContext context, bool? value, Todo item) {
    ScaffoldMessenger.of(context).clearSnackBars();
    final Todo task = item.copyWith(isCompleted: value);
    context.read<TodoBloc>().add(UpdateTodo(todo: task));
  }

  removeTodo(BuildContext context, Todo item) {
    ScaffoldMessenger.of(context).clearSnackBars();
    context.read<TodoBloc>().add(RemoveTodo(todo: item));
  }
}
