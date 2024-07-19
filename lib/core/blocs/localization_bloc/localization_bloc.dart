import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo_fda_mvvm_bloc/core/utils/helpers/shared_preference_helper.dart';
part 'localization_event.dart';
part 'localization_state.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  LocalizationBloc() : super(const LocalizationInitial(Locale("en"))) {
    on<ChangeLanguage>((event, emit) {
      SharedPreferenceHelper().saveString("languageCode", event.languageCode);
      emit(LanguageChanged(newLocale: Locale(event.languageCode)));
    });
  }
}
