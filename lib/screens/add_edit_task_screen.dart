import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miles_assignment/models/priority.dart';
import 'package:miles_assignment/models/task.dart';
import 'package:miles_assignment/providers/providers.dart';
import 'package:miles_assignment/widgets/custom_text_field.dart';

class AddEditTaskScreen extends ConsumerStatefulWidget {
  final Task? task;

  const AddEditTaskScreen({super.key, this.task});

  @override
  ConsumerState<AddEditTaskScreen> createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends ConsumerState<AddEditTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  Priority _selectedPriority = Priority.low;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
      _selectedPriority = widget.task!.priority;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _saveTask() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final task = Task(
        id: widget.task?.id ?? '',
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        createdOn: widget.task?.createdOn ?? DateTime.now(),
        priority: _selectedPriority,
        userId: ref.read(currentUserProvider)?.uid ?? '',
      );

      if (widget.task == null) {
        await ref.read(taskServiceProvider).addTask(task);
      } else {
        await ref.read(taskServiceProvider).updateTask(task);
      }

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.task == null ? 'Add Task' : 'Edit Task',
          style: TextStyle(fontSize: 20.sp),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  controller: _titleController,
                  hintText: 'Task Title',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                CustomTextField(
                  controller: _descriptionController,
                  hintText: 'Task Description',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24.h),
                Text(
                  'Priority',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                LayoutBuilder(
                  builder: (context, constraints) {
                    return constraints.maxWidth > 600
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: _buildPriorityButtons(),
                          )
                        : Column(children: _buildPriorityButtons());
                  },
                ),
                SizedBox(height: 32.h),
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    onPressed: _isLoading ? null : _saveTask,
                    child: _isLoading
                        ? SizedBox(
                            height: 24.r,
                            width: 24.r,
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            widget.task == null ? 'Add Task' : 'Update Task',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildPriorityButtons() {
    return Priority.values.map((priority) {
      final isSelected = _selectedPriority == priority;
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isSelected ? Colors.black : Colors.grey[200],
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          onPressed: () {
            setState(() => _selectedPriority = priority);
          },
          child: Text(
            priority.name.toUpperCase(),
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }).toList();
  }
}
