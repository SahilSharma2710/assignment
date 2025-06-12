import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miles_assignment/models/priority.dart';
import 'package:miles_assignment/models/task.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TaskItem({
    super.key,
    required this.task,
    required this.onEdit,
    required this.onDelete,
  });

  Color _getPriorityColor() {
    switch (task.priority) {
      case Priority.high:
        return Colors.red.shade100;
      case Priority.medium:
        return Colors.orange.shade100;
      case Priority.low:
        return Colors.green.shade100;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _getPriorityColor(),
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: ListTile(
        contentPadding: EdgeInsets.all(16.r),
        title: Text(
          task.title,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.h),
            Text(task.description, style: TextStyle(fontSize: 14.sp)),
            SizedBox(height: 8.h),
            Row(
              children: [
                Icon(
                  Icons.flag,
                  color: task.priority == Priority.high
                      ? Colors.red
                      : task.priority == Priority.medium
                      ? Colors.orange
                      : Colors.green,
                  size: 20.r,
                ),
                SizedBox(width: 8.w),
                Text(
                  task.priority.name.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, size: 24.r),
              onPressed: onEdit,
            ),
            IconButton(
              icon: Icon(Icons.delete, size: 24.r),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
