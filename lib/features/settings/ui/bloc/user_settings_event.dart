part of 'user_settings_bloc.dart';

abstract class UserSettingsEvent extends Equatable {
  const UserSettingsEvent();

  @override
  List<Object> get props => [];
}

class LoadUserSettings extends UserSettingsEvent {}

class ChangeLanguage extends UserSettingsEvent {
  final String newLang;

  const ChangeLanguage(this.newLang);

  @override
  List<Object> get props => [newLang];
}
