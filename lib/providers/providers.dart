import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miles_assignment/models/task.dart';
import 'package:miles_assignment/services/auth_service.dart';
import 'package:miles_assignment/services/task_service.dart';

// Auth Providers
final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

final currentUserProvider = Provider<User?>((ref) {
  return ref.watch(authStateProvider).value;
});

// Task Providers
final taskServiceProvider = Provider<TaskService>((ref) => TaskService());

final tasksStreamProvider = StreamProvider<List<Task>>((ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return Stream.value([]);

  return ref.watch(taskServiceProvider).getTasks();
});
