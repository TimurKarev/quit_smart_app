// lib/features/auth/ui/bloc/auth_event.dart
part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

// Event to request starting the observation of the user authentication stream
class AuthSubscriptionRequested extends AuthEvent {
  const AuthSubscriptionRequested();
}

// Event triggered by UI to request Google sign-in
class AuthGoogleSignInRequested extends AuthEvent {
  const AuthGoogleSignInRequested();
}

class AuthAppleSignInRequested extends AuthEvent {
  const AuthAppleSignInRequested();
}

// Event triggered by UI to request sign-out
class AuthSignOutRequested extends AuthEvent {
  const AuthSignOutRequested();
}
