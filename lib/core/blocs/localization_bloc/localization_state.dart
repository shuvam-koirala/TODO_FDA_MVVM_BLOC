part of 'localization_bloc.dart';

@immutable
sealed class LocalizationState extends Equatable {
  final Locale locale;
  const LocalizationState({required this.locale});
  @override
  List<Object> get props => [locale];
}

final class LocalizationInitial extends LocalizationState {
  const LocalizationInitial(Locale locale) : super(locale: locale);
}

final class LanguageChanged extends LocalizationState {
  final Locale newLocale;
  const LanguageChanged({required this.newLocale}) : super(locale: newLocale);
  LanguageChanged copyWith({Locale? newLocale}) {
    return LanguageChanged(newLocale: newLocale ?? locale);
  }

  @override
  List<Object> get props => [newLocale];
}
