part of 'localization_bloc.dart';

@immutable
sealed class LocalizationEvent extends Equatable {
  const LocalizationEvent();
}

class ChangeLanguage extends LocalizationEvent {
  final String languageCode;
  const ChangeLanguage({required this.languageCode});
  @override
  List<Object> get props => [languageCode];
}
