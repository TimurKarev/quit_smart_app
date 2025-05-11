// lib/features/auth/ui/bloc/auth_bloc.dart
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quit_smart_app/features/auth/domain/models/app_user.dart';
import 'package:quit_smart_app/features/auth/domain/repository/auth_repository.dart';
import 'package:quit_smart_app/utils/data/either.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(const AuthState.init()) {
    on<AuthSubscriptionRequested>(_onAuthSubscriptionRequested);
    on<AuthGoogleSignInRequested>(_onGoogleSignInRequested);
    on<AuthSignOutRequested>(_onSignOutRequested);

    add(const AuthSubscriptionRequested());
  }

  Future<void> _onAuthSubscriptionRequested(
    AuthSubscriptionRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await emit.forEach<Either<AppUser>>(
      _authRepository.getUser(),
      onData: (eitherUser) {
        AuthState stateToEmit = state;
        eitherUser.fold(
          (failure) {
            stateToEmit = AuthState(
              user: const UnauthenticatedUser(),
              failureMessage: failure.message,
              isLoading: false,
            );
          },
          (user) {
            if (user is AuthenticatedUser) {
              stateToEmit = AuthState(
                user: user,
                failureMessage: '',
                isLoading: false,
              );
            } else {
              stateToEmit = AuthState(
                user: const UnauthenticatedUser(),
                failureMessage: 'unknownError',
                isLoading: false,
              );
            }
          },
        );
        return stateToEmit;
      },
      onError: (error, stackTrace) {
        return AuthState(
          user: const UnauthenticatedUser(),
          failureMessage: error.toString(),
          isLoading: false,
        );
      },
    );
  }

  Future<void> _onGoogleSignInRequested(
    AuthGoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _authRepository.signInWithGoogle();
    if (!result.isSuccess) {
      emit(
        state.copyWith(
          isLoading: false,
          failureMessage: result.failure?.message,
        ),
      );
    }
  }

  Future<void> _onSignOutRequested(
    AuthSignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _authRepository.logOut();
    result.fold(
      (failure) => emit(
        state.copyWith(isLoading: false, failureMessage: failure.message),
      ),
      (unauthenticatedUser) {
        emit(state.copyWith(isLoading: false, user: unauthenticatedUser));
      },
    );
  }
}
