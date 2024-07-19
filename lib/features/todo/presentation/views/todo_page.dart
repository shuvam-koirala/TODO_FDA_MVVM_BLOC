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
              final Todo todo = Todo(
                  id: context.read<TodoBloc>().state.todos.length.toString(),
                  description: "hello",
                  title: "tt",
                  isCompleted: false);
              context.read<TodoBloc>().add(AddTodo(todo: todo));
            },
            child: Icon(Icons.plus_one),
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
          body: BlocBuilder<TodoBloc, TodoState>(
            builder: (context, state) {
              switch (state.status) {
                case TodoListStatus.loading:
                  return const CircularProgressIndicator();
                case TodoListStatus.error:
                  return const Text("Something went wrong.");
                case TodoListStatus.success:
                  return ListView.builder(
                      itemCount: state.todos.length,
                      itemBuilder: (context, index) {
                        final item = state.todos[index];
                        return Card(
                          child: ListTile(
                            title: Text(item.title),
                            subtitle: Text(item.description),
                          ),
                        );
                      });
              }
            },
          )),
    );
  }
}
