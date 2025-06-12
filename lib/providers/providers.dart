import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miles_assignment/models/task.dart';
import 'package:miles_assignment/services/auth_service.dart';
import 'package:miles_assignment/services/task_service.dart';

/// Provider for the AuthService instance.
///
/// This provider makes the AuthService available throughout the app
/// for handling authentication operations.
final authServiceProvider = Provider<AuthService>((ref) => AuthService());

/// StreamProvider that provides the current authentication state.
///
/// This provider streams changes to the user's authentication state,
/// allowing the app to react to sign-in/sign-out events in real-time.
final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

/// Provider that exposes the current user object.
///
/// This provider depends on authStateProvider and makes the current
/// user object easily accessible throughout the app.
final currentUserProvider = Provider<User?>((ref) {
  return ref.watch(authStateProvider).value;
});

/// Provider for the TaskService instance.
///
/// This provider makes the TaskService available throughout the app
/// for handling task-related operations.
final taskServiceProvider = Provider<TaskService>((ref) => TaskService());

/// StreamProvider that provides the list of tasks for the current user.
///
/// This provider automatically fetches and streams tasks for the currently
/// authenticated user, updating the UI in real-time when tasks change.
final tasksStreamProvider = StreamProvider<List<Task>>((ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return Stream.value([]);

  return ref.watch(taskServiceProvider).getTasks(user.uid);
});
