import "package:get_it/get_it.dart";
import "package:sqflite/sqflite.dart";
import "package:todo_fda_mvvm_bloc/barrel.dart";
import "package:todo_fda_mvvm_bloc/core/services/database_service.dart";
import "package:todo_fda_mvvm_bloc/features/todo/data/repositories/todo_sql_db_repository.dart";
import "package:todo_fda_mvvm_bloc/features/todo/data/repositories/todo_repository.dart";

late Database database;
late GetIt getIt;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  getIt = GetIt.instance;
  serviceLocator(i: getIt);
  await SharedPreferenceHelper().init();
  await DatabaseService().init();
  runApp(MyApp(
    router: NavigationRouter(),
    blocHelper: MultiBlocHelper(),
  ));
}

void serviceLocator({required GetIt i}) {
  i.registerLazySingleton<TodoRepository>(() => TodoSqlDbRepository());
}

class MyApp extends StatelessWidget {
  const MyApp({required this.router, required this.blocHelper, super.key});
  final NavigationRouter router;
  final MultiBlocHelper blocHelper;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocHelper.getProviders(),
      child: BlocBuilder<LocalizationBloc, LocalizationState>(
        builder: (context, localeState) {
          return BlocBuilder<ThemeChangerCubit, ThemeChangerState>(
            builder: (context, themeState) {
              return MaterialApp(
                title: 'TODO_FDA_MVVM_BLOC',
                locale: localeState.locale,
                theme: ThemeData(
                  brightness: themeState.brightness,
                  colorScheme: ColorScheme.fromSeed(
                      seedColor: Colors.deepPurple,
                      brightness: themeState.brightness),
                  useMaterial3: true,
                ),
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                onGenerateRoute: router.onGenerateRoute,
                debugShowCheckedModeBanner: false,
                debugShowMaterialGrid: false,
              );
            },
          );
        },
      ),
    );
  }
}
