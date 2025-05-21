import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_settings_event.dart';
part 'user_settings_state.dart';

class UserSettingsBloc extends Bloc<UserSettingsEvent, UserSettingsState> {
  UserSettingsBloc() : super(const UserSettingsState(lang: 'en')) {
    on<LoadUserSettings>(_onLoadUserSettings);
    on<ChangeLanguage>(_onChangeLanguage);
  }

  void _onLoadUserSettings(
    LoadUserSettings event,
    Emitter<UserSettingsState> emit,
  ) {
    final String systemLang = PlatformDispatcher.instance.locale.languageCode;
    // In a real app, you might also load persisted settings and compare with systemLang
    emit(UserSettingsState(lang: systemLang));
  }

  void _onChangeLanguage(
    ChangeLanguage event,
    Emitter<UserSettingsState> emit,
  ) {
    emit(UserSettingsState(lang: event.newLang));
  }
}
