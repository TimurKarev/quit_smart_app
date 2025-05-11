import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quit_smart_app/features/auth/domain/models/app_user.dart';
import 'package:quit_smart_app/features/auth/domain/repository/auth_repository.dart';
import 'package:quit_smart_app/utils/data/either.dart';
import 'package:quit_smart_app/utils/data/failure.dart';
import 'package:rxdart/rxdart.dart';

// Implementation of AuthRepository using Firebase Authentication and Google Sign-In.
class FireAuthRepository implements AuthRepository {
  // Firebase Authentication instance for user management.
  final firebase_auth.FirebaseAuth firebaseAuth;

  // Constructor, allowing injection of FirebaseAuth and GoogleSignIn instances
  // for testing or custom configuration. Defaults to standard instances if not provided.
  FireAuthRepository({required this.firebaseAuth});

  // Provides a stream of the current authentication state, mapped to AppUser subtypes.
  // Emits AuthenticatedUser if a user is signed in, otherwise UnauthenticatedUser.
  // Wraps results in Either to handle potential errors during stream processing.
  @override
  Stream<Either<AppUser>> getUser() {
    // Listen to Firebase auth state changes.
    return firebaseAuth
        .authStateChanges()
        .map((firebaseUser) {
          if (firebaseUser != null) {
            // If a Firebase user exists, create an AuthenticatedUser.
            final appUser = AuthenticatedUser(uid: firebaseUser.uid);
            return Either.success(
              appUser,
            ); // Emit success with AuthenticatedUser.
          } else {
            // If no Firebase user, emit success with UnauthenticatedUser.
            return Either.success(const UnauthenticatedUser());
          }
        })
        .onErrorReturnWith((error, stackTrace) {
          // If an error occurs in the stream, emit a Failure.
          return Either.error(
            Failure(
              type: FailureType.authenticationFailure,
              message: 'Error observing auth state: ${error.toString()}',
            ),
          );
        });
  }

  // Signs in the user with Google and returns an AppUser (AuthenticatedUser on success).
  // Wraps the result in Either to handle success or Failure.
  @override
  Future<Either<AppUser>> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    try {
      // Attempt to sign in with Google.
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        // User cancelled the Google sign-in flow.
        return Either.error(
          Failure(
            type: FailureType.authenticationFailure,
            message: 'Google sign-in cancelled by user.',
          ),
        );
      }

      // Obtain authentication details from the Google user.
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      // Create a Firebase credential using Google auth details.
      final firebase_auth.AuthCredential credential = firebase_auth
          .GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential.
      final firebase_auth.UserCredential userCredential = await firebaseAuth
          .signInWithCredential(credential);
      final firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        // If Firebase sign-in is successful, create and emit AuthenticatedUser.
        final appUser = AuthenticatedUser(uid: firebaseUser.uid);
        return Either.success(appUser);
      } else {
        // Should not happen if signInWithCredential succeeds without error, but handle defensively.
        return Either.error(
          Failure(
            type: FailureType.authenticationFailure,
            message: 'Failed to retrieve user data after Google sign-in.',
          ),
        );
      }
    } catch (e) {
      // Handle any other errors during the Google sign-in process.
      return Either.error(
        Failure(
          type: FailureType.authenticationFailure,
          message: 'Google sign-in failed: ${e.toString()}',
        ),
      );
    }
  }

  // Logs out the current user from both Firebase and Google Sign-In.
  // Returns UnauthenticatedUser on successful logout.
  // Wraps the result in Either to handle success or Failure.
  @override
  Future<Either<AppUser>> logOut() async {
    final googleSignIn = GoogleSignIn();
    try {
      await googleSignIn.signOut(); // Sign out from Google.
      await firebaseAuth.signOut(); // Sign out from Firebase.
      // Emit success with UnauthenticatedUser upon successful logout.
      return Either.success(const UnauthenticatedUser());
    } catch (e) {
      // Handle any errors during the logout process.
      return Either.error(
        Failure(
          type: FailureType.authenticationFailure,
          message: 'Logout failed: ${e.toString()}',
        ),
      );
    }
  }
}
