import 'package:todo_fda_mvvm_bloc/barrel.dart';
part 'theme_changer_state.dart';

class ThemeChangerCubit extends Cubit<ThemeChangerState> {
  ThemeChangerCubit()
      : super(const ThemeChangerInitial(brightness: Brightness.light));

  changeTheme({required Brightness brightness}) {
    SharedPreferenceHelper()
        .saveBool('hasLightTheme', brightness == Brightness.light);
    emit(ThemeChanged(brightness: brightness));
  }
}
