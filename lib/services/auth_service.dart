import 'package:firebase_auth/firebase_auth.dart';

/// Service class for handling Firebase Authentication operations.
///
/// This class provides methods for user authentication operations such as
/// sign up, sign in, and sign out. It also includes error handling for
/// common authentication scenarios.
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Returns the currently authenticated user or null if not authenticated.
  User? get currentUser => _auth.currentUser;

  /// Creates a new user account with the provided email and password.
  ///
  /// Throws a formatted error message if the operation fails.
  ///
  /// Parameters:
  /// - [email]: The user's email address
  /// - [password]: The user's password (must be at least 6 characters)
  Future<UserCredential> signUp({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw _handleAuthException(e);
    }
  }

  /// Signs in an existing user with email and password.
  ///
  /// Throws a formatted error message if the operation fails.
  ///
  /// Parameters:
  /// - [email]: The user's email address
  /// - [password]: The user's password
  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw _handleAuthException(e);
    }
  }

  /// Signs out the currently authenticated user.
  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// Handles Firebase Authentication exceptions and returns user-friendly error messages.
  ///
  /// Parameters:
  /// - [e]: The exception to handle
  ///
  /// Returns a user-friendly error message string.
  String _handleAuthException(dynamic e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'weak-password':
          return 'The password provided is too weak.';
        case 'email-already-in-use':
          return 'An account already exists for that email.';
        case 'user-not-found':
          return 'No user found for that email.';
        case 'wrong-password':
          return 'Wrong password provided.';
        default:
          return 'Authentication error occurred.';
      }
    }
    return 'An error occurred. Please try again.';
  }
}
