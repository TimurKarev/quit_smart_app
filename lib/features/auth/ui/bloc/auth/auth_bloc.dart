// lib/features/auth/ui/bloc/auth_bloc.dart
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart'; // Import for debugPrint
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
  }

  Future<void> _onAuthSubscriptionRequested(
    AuthSubscriptionRequested event,
    Emitter<AuthState> emit,
  ) async {
    print('[AuthBloc] _onAuthSubscriptionRequested: Subscribing to user stream...');
    // emit(state.copyWith(user: const UnknownUser())); // Initial state is already UnknownUser

    await emit.onEach<Either<AppUser>>(
      _authRepository.getUser(),
      onData: (eitherUser) {
        print('[AuthBloc] _onAuthSubscriptionRequested: onData received: $eitherUser');
        AuthState stateToEmit = state; // Initialize with current state
        eitherUser.fold(
          (failure) {
            print('[AuthBloc] _onAuthSubscriptionRequested: onData - failure: ${failure.message}');
            stateToEmit = AuthState(
              user: const UnauthenticatedUser(),
              failureMessage: failure.message,
            );
          },
          (user) {
            print('[AuthBloc] _onAuthSubscriptionRequested: onData - success: $user');
            if (user is AuthenticatedUser) {
              stateToEmit = AuthState(
                user: user,
                failureMessage: '',
              );
            } else {
              stateToEmit = AuthState(
                user: const UnauthenticatedUser(),
                failureMessage: '',
              );
            }
          },
        );
        emit(stateToEmit); // Emit the new state
      },
      onError: (error, stackTrace) {
        print('[AuthBloc] _onAuthSubscriptionRequested: onError: $error');
        // It's important to emit a state here too, otherwise BLoC might not update.
        emit(AuthState(
          user: const UnauthenticatedUser(), 
          failureMessage: error.toString(),
        ));
      },
    );
    print('[AuthBloc] _onAuthSubscriptionRequested: Subscription ended or stream closed.');
  }

  Future<void> _onGoogleSignInRequested(
    AuthGoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(user: const UnknownUser()));
    final result = await _authRepository.signInWithGoogle();
    if (!result.isSuccess) {
      emit(
        state.copyWith(
          user: const UnauthenticatedUser(),
          failureMessage: result.failure?.message,
        ),
      );
    } 
    // On success, the user stream from _onAuthSubscriptionRequested will emit AuthenticatedUser
  }

  Future<void> _onSignOutRequested(
    AuthSignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    debugPrint('[AuthBloc] _onSignOutRequested: Sign out process started.');
    // Optionally, emit a loading/unknown state if sign-out is not instantaneous
    // emit(state.copyWith(user: const UnknownUser())); 
    // However, for sign-out, directly going to UnauthenticatedUser is often fine.

    final result = await _authRepository.logOut(); // Corrected: Was signOut()

    result.fold(
      (failure) {
        debugPrint('[AuthBloc] _onSignOutRequested: Sign out failed. Error: $failure');
        // Optionally, emit a state indicating sign-out failure, 
        // or revert to previous state if optimistic update was done.
        // For now, we'll assume it falls through to unauthenticated or handles error appropriately elsewhere.
        // If still authenticated technically, this might be an issue. 
        // But typically, even on failure, UI goes to unauth state.
        emit(state.copyWith(user: const UnauthenticatedUser())); // Or a specific error state if needed
      },
      (_) {
        debugPrint('[AuthBloc] _onSignOutRequested: Sign out successful. Emitting UnauthenticatedUser.');
        emit(state.copyWith(user: const UnauthenticatedUser()));
      },
    );
    debugPrint('[AuthBloc] _onSignOutRequested: Sign out process finished. Current state: ${state.user}');
  }
}
