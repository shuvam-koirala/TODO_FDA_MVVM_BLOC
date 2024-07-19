import 'package:todo_fda_mvvm_bloc/barrel.dart';
import 'package:todo_fda_mvvm_bloc/features/todo/data/repositories/todo_repository.dart';
import 'package:todo_fda_mvvm_bloc/features/todo/domain/usecases/todo_usecase.dart';
import 'package:todo_fda_mvvm_bloc/features/todo/presentation/blocs/todo_bloc/todo_bloc.dart';
import 'package:todo_fda_mvvm_bloc/main.dart';

final class MultiBlocHelper {
  getProviders() {
    return [
      BlocProvider(create: (context) => LocalizationBloc()),
      BlocProvider(create: (context) => ThemeChangerCubit()),
      BlocProvider(
          create: (context) => TodoBloc(TodoUsecase(getIt<TodoRepository>())))
    ];
  }
}
