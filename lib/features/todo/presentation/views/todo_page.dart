import "package:todo_fda_mvvm_bloc/barrel.dart";
import "package:todo_fda_mvvm_bloc/features/todo/domain/entities/todo.dart";
import "package:todo_fda_mvvm_bloc/features/todo/presentation/blocs/todo_bloc/todo_bloc.dart";

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  void initState() {
    context.read<TodoBloc>().add(GetTodos());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              ScaffoldMessenger.of(context).clearSnackBars();
              final String todoCount =
                  context.read<TodoBloc>().state.todos.length.toString();
              final Todo todo = Todo(
                  id: todoCount,
                  description: "Complete this task",
                  title: "Task $todoCount",
                  isCompleted: false);
              context.read<TodoBloc>().add(AddTodo(todo: todo));
            },
            child: const Icon(Icons.plus_one),
          ),
          appBar: AppBar(actions: [
            IconButton(
                onPressed: () {
                  context.read<ThemeChangerCubit>().changeTheme(
                      brightness:
                          context.read<ThemeChangerCubit>().state.brightness ==
                                  Brightness.light
                              ? Brightness.dark
                              : Brightness.light);
                },
                icon: const Icon(Icons.light)),
            BlocBuilder<LocalizationBloc, LocalizationState>(
              buildWhen: (previous, current) =>
                  previous.locale.languageCode != current.locale.languageCode,
              builder: (context, state) {
                return Text(state.locale.languageCode);
              },
            ),
            IconButton(
                onPressed: () {
                  context.read<LocalizationBloc>().add(ChangeLanguage(
                      languageCode: context
                                  .read<LocalizationBloc>()
                                  .state
                                  .locale
                                  .languageCode ==
                              "en"
                          ? "ne"
                          : "en"));
                },
                icon: const Icon(Icons.language))
          ], title: Text(AppLocalizations.of(context)!.todopage_todo_list)),
          body: BlocConsumer<TodoBloc, TodoState>(
            listener: (context, state) {
              switch (state.status) {
                case TodoListStatus.added:
                case TodoListStatus.deleted:
                case TodoListStatus.updated:
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
                  context.read<TodoBloc>().add(GetTodos());
                  break;
                case TodoListStatus.errorAdding:
                case TodoListStatus.errorDeleting:
                case TodoListStatus.errorUpdating:
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
                  break;

                default:
              }
            },
            // buildWhen: (current, previous) => current.status != previous.status,
            builder: (context, state) {
              switch (state.status) {
                case TodoListStatus.loading:
                  return const CircularProgressIndicator();
                case TodoListStatus.errorLoading:
                  return Column(
                    children: [
                      const Text("Something went wrong."),
                      ElevatedButton(
                          onPressed: () {
                            context.read<TodoBloc>().add(GetTodos());
                          },
                          child: const Text("Try Again"))
                    ],
                  );
                default:
                  return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: state.todos.length,
                      itemBuilder: (context, index) {
                        final item = state.todos[index];
                        return Card(
                          color: Colors.white,
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            tileColor: Colors.white,
                            title: Text(
                              item.title,
                              style: TextStyle(
                                  decoration: item.isCompleted
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none),
                            ),
                            subtitle: Text(
                              item.description,
                              style: TextStyle(
                                  decoration: item.isCompleted
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none),
                            ),
                            trailing: Wrap(
                              children: [
                                Checkbox.adaptive(
                                    value: item.isCompleted,
                                    onChanged: (value) {
                                      ScaffoldMessenger.of(context)
                                          .clearSnackBars();
                                      final Todo task =
                                          item.copyWith(isCompleted: value);
                                      context
                                          .read<TodoBloc>()
                                          .add(UpdateTodo(todo: task));
                                    }),
                                IconButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .clearSnackBars();
                                      context
                                          .read<TodoBloc>()
                                          .add(RemoveTodo(todo: item));
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    )),
                              ],
                            ),
                          ),
                        );
                      });
              }
            },
          )),
    );
  }
}
