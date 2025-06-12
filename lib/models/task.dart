import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:miles_assignment/models/priority.dart';

/// Represents a task in the application.
///
/// This class defines the structure of a task with properties like
/// title, description, priority, and creation date. It also provides
/// methods for converting to and from Firestore data.
class Task {
  /// Unique identifier for the task
  final String id;

  /// Title of the task
  final String title;

  /// Detailed description of the task
  final String description;

  /// Date and time when the task was created
  final DateTime createdOn;

  /// Priority level of the task (high, medium, or low)
  final Priority priority;

  /// ID of the user who created the task
  final String userId;

  /// Creates a new task instance.
  ///
  /// All parameters are required to ensure data consistency.
  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.createdOn,
    required this.priority,
    required this.userId,
  });

  /// Converts the task instance to a map for Firestore storage.
  ///
  /// The createdOn DateTime is converted to a Firestore Timestamp.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdOn': Timestamp.fromDate(createdOn),
      'priority': priority.name,
      'userId': userId,
    };
  }

  /// Creates a task instance from a Firestore document map.
  ///
  /// Handles null values and type conversions from Firestore data types.
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      createdOn: (map['createdOn'] as Timestamp).toDate(),
      priority: Priority.values.firstWhere(
        (e) => e.name == map['priority'],
        orElse: () => Priority.low,
      ),
      userId: map['userId'] ?? '',
    );
  }
}
