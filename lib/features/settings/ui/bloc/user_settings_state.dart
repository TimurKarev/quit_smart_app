part of 'user_settings_bloc.dart';

class UserSettingsState extends Equatable {
  final String lang;

  const UserSettingsState({required this.lang});

  @override
  List<Object> get props => [lang];
}
