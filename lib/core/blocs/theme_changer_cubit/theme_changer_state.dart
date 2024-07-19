part of 'theme_changer_cubit.dart';

sealed class ThemeChangerState extends Equatable {
  const ThemeChangerState({required this.brightness});
  final Brightness brightness;
  @override
  List<Object> get props => [brightness];
}

final class ThemeChangerInitial extends ThemeChangerState {
  const ThemeChangerInitial({required super.brightness});
}

final class ThemeChanged extends ThemeChangerState {
  const ThemeChanged({required super.brightness});
}
