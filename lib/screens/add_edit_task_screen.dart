import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
        title: Text(widget.task == null ? 'Add Task' : 'Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
              const SizedBox(height: 16),
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
              const SizedBox(height: 24),
              const Text(
                'Priority',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: SegmentedButton<Priority>(
                      segments: Priority.values
                          .map(
                            (priority) => ButtonSegment<Priority>(
                              value: priority,
                              label: Text(
                                priority.name.toUpperCase(),
                                style: TextStyle(
                                  color: _selectedPriority == priority
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      selected: {_selectedPriority},
                      onSelectionChanged: (Set<Priority> newSelection) {
                        setState(() {
                          _selectedPriority = newSelection.first;
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.resolveWith<Color>(
                          (Set<WidgetState> states) {
                            if (states.contains(WidgetState.selected)) {
                              return Colors.green.shade400;
                            }
                            return Colors.transparent;
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  onPressed: _isLoading ? null : _saveTask,
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : Text(
                          widget.task == null ? 'Add Task' : 'Update Task',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
