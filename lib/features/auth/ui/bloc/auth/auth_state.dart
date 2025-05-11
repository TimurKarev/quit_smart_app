// lib/features/auth/ui/bloc/auth_state.dart
part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState({
    required this.user,
    required this.failureMessage,
    required this.isLoading,
  });

  const AuthState.init()
    : this(
        user: const UnauthenticatedUser(),
        failureMessage: '',
        isLoading: false,
      );

  AuthState copyWith({AppUser? user, String? failureMessage, bool? isLoading}) {
    return AuthState(
      user: user ?? this.user,
      failureMessage: failureMessage ?? this.failureMessage,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  final AppUser user;
  final String failureMessage;
  final bool isLoading;

  @override
  List<Object> get props => [user, failureMessage, isLoading];
}
