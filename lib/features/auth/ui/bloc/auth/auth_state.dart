// lib/features/auth/ui/bloc/auth_state.dart
part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState({
    required this.user,
    required this.failureMessage,
  });

  const AuthState.init()
    : this(
        user: const UnknownUser(),
        failureMessage: '',
      );

  AuthState copyWith({AppUser? user, String? failureMessage}) {
    return AuthState(
      user: user ?? this.user,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }

  final AppUser user;
  final String failureMessage;

  @override
  List<Object> get props => [user, failureMessage];
}
