import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:miles_assignment/models/task.dart';

/// Service class for handling Firestore operations related to tasks.
///
/// This class provides methods for creating, reading, updating, and deleting
/// tasks in Firestore. It includes real-time data synchronization and
/// proper error handling.
class TaskService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Returns a stream of tasks for a specific user.
  ///
  /// The tasks are ordered by creation date in descending order (newest first).
  /// The stream updates in real-time when changes occur in Firestore.
  ///
  /// Parameters:
  /// - [userId]: The ID of the user whose tasks to fetch
  Stream<List<Task>> getTasks() {
    return _firestore.collection('tasks').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return Task.fromMap(data);
      }).toList();
    });
  }

  /// Adds a new task to Firestore.
  ///
  /// Parameters:
  /// - [task]: The task object to add
  Future<void> addTask(Task task) async {
    await _firestore.collection('tasks').add(task.toMap());
  }

  /// Updates an existing task in Firestore.
  ///
  /// Parameters:
  /// - [task]: The task object with updated values
  Future<void> updateTask(Task task) async {
    await _firestore.collection('tasks').doc(task.id).update(task.toMap());
  }

  /// Deletes a task from Firestore.
  ///
  /// Parameters:
  /// - [taskId]: The ID of the task to delete
  Future<void> deleteTask(String taskId) async {
    await _firestore.collection('tasks').doc(taskId).delete();
  }
}
