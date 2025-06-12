import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:miles_assignment/models/priority.dart';

class Task {
  final String id;
  final String title;
  final String description;
  final DateTime createdOn;
  final Priority priority;
  final String userId;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.createdOn,
    required this.priority,
    required this.userId,
  });

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
