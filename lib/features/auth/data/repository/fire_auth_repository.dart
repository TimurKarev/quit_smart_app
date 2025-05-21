import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quit_smart_app/features/auth/domain/models/app_user.dart';
import 'package:quit_smart_app/features/auth/domain/repository/auth_repository.dart';
import 'package:quit_smart_app/utils/data/either.dart';
import 'package:quit_smart_app/utils/data/failure.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'dart:math';
import 'dart:convert';
import 'package:crypto/crypto.dart';

// Implementation of AuthRepository using Firebase Authentication and Google Sign-In.
class FireAuthRepository implements AuthRepository {
  // Firebase Authentication instance for user management.
  final FirebaseAuth firebaseAuth;

  // Constructor, allowing injection of FirebaseAuth and GoogleSignIn instances
  // for testing or custom configuration. Defaults to standard instances if not provided.
  FireAuthRepository({required this.firebaseAuth});

  // Provides a stream of the current authentication state, mapped to AppUser subtypes.
  // Emits AuthenticatedUser if a user is signed in, otherwise UnauthenticatedUser.
  // Wraps results in Either to handle potential errors during stream processing.
  @override
  Stream<Either<AppUser>> getUser() {
    // Listen to Firebase auth state changes.
    return firebaseAuth.authStateChanges().map((firebaseUser) {
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
    }).onErrorReturnWith((error, stackTrace) {
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
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential.
      final UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);
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

  String _generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  @override
  Future<Either<AppUser>> signInWithApple() async {
    try {
      // 1. Generate a cryptographically secure random nonce.
      final rawNonce = _generateNonce();
      // 2. Create a SHA256 hash of the nonce.
      final nonceHash = sha256.convert(utf8.encode(rawNonce)).toString();

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonceHash, // Pass the HASHED nonce to Apple
      );

      final oAuthProvider = OAuthProvider('apple.com');
      // 3. Use the ORIGINAL (unhashed) rawNonce when creating the Firebase credential.
      final credential = oAuthProvider.credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce // Use the original rawNonce here
      );

      final userCredential =
          await firebaseAuth.signInWithCredential(credential);
      final firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        final appUser = AuthenticatedUser(uid: firebaseUser.uid);
        return Either.success(appUser);
      } else {
        return Either.error(
          Failure(
            type: FailureType.authenticationFailure,
            message: 'Failed to retrieve user data after Apple sign-in.',
          ),
        );
      }
    } on SignInWithAppleException catch (e) {
      // Handle specific Apple sign-in exceptions (e.g., cancelled by user)
      return Either.error(
        Failure(
          type: FailureType.authenticationFailure,
          message: 'Apple sign-in failed: ${e.toString()}',
        ),
      );
    } catch (e) {
      return Either.error(
        Failure(
          type: FailureType.authenticationFailure,
          message: 'Apple sign-in failed: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<AppUser>> signInWithCredentials({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      final firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        final appUser = AuthenticatedUser(uid: firebaseUser.uid);
        return Either.success(appUser);
      } else {
        // This case should ideally not be reached if signInWithEmailAndPassword succeeds.
        return Either.error(
          Failure(
            type: FailureType.authenticationFailure,
            message: 'Failed to retrieve user data after sign-in.',
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      String message = 'An unknown error occurred.';
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      } else if (e.code == 'invalid-email') {
        message = 'The email address is not valid.';
      }
      return Either.error(
        Failure(
          type: FailureType.authenticationFailure,
          message: message,
        ),
      );
    } catch (e) {
      return Either.error(
        Failure(
          type: FailureType.authenticationFailure,
          message: 'Sign-in failed: ${e.toString()}',
        ),
      );
    }
  }
}
