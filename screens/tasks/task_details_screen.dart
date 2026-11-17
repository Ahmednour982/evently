import 'package:flutter/material.dart';
import '../../services/storage_service.dart';
import '../../models/event_model.dart';

class TaskDetailsScreen extends StatefulWidget {
  final String taskId;
  const TaskDetailsScreen({super.key, required this.taskId});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  TaskModel? _task;

  @override
  void initState() {
    super.initState();
    _loadTask();
  }

  void _loadTask() {
    setState(() {
      _task = StorageService.getTask(widget.taskId);
    });
  }

  Future<void> _toggleComplete() async {
    if (_task == null) return;
    final updated = TaskModel(
      id: _task!.id,
      title: _task!.title,
      type: _task!.type,
      description: _task!.description,
      dateTime: _task!.dateTime,
      priority: _task!.priority,
      isCompleted: !_task!.isCompleted,
      isFavorite: _task!.isFavorite,
      createdAt: _task!.createdAt,
      updatedAt: DateTime.now().toIso8601String(),
    );
    await StorageService.updateTask(updated);
    _loadTask();
  }

  Future<void> _toggleFavorite() async {
    if (_task == null) return;
    final updated = TaskModel(
      id: _task!.id,
      title: _task!.title,
      type: _task!.type,
      description: _task!.description,
      dateTime: _task!.dateTime,
      priority: _task!.priority,
      isCompleted: _task!.isCompleted,
      isFavorite: !_task!.isFavorite,
      createdAt: _task!.createdAt,
      updatedAt: DateTime.now().toIso8601String(),
    );
    await StorageService.updateTask(updated);
    _loadTask();
  }

  Future<void> _deleteTask() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Task'),
        content: const Text('Are you sure?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true && _task != null) {
      await StorageService.deleteTask(_task!.id);
      if (mounted) Navigator.pop(context);
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'high': return Colors.red;
      case 'medium': return Colors.orange;
      case 'low': return Colors.green;
      default: return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_task == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Task Details')),
        body: const Center(child: Text('Task not found')),
      );
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Task Details'),
        actions: [
          IconButton(
            icon: Icon(_task!.isFavorite ? Icons.favorite : Icons.favorite_border),
            color: _task!.isFavorite ? Colors.red : null,
            onPressed: _toggleFavorite,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            color: Colors.red,
            onPressed: _deleteTask,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: _getPriorityColor(_task!.priority).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _task!.priority.toUpperCase(),
                          style: TextStyle(color: _getPriorityColor(_task!.priority), fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: _task!.isCompleted ? Colors.green.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _task!.isCompleted ? 'COMPLETED' : 'PENDING',
                          style: TextStyle(
                            color: _task!.isCompleted ? Colors.green : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _task!.title,
                    style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _task!.type.toUpperCase(),
                    style: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (_task!.description != null)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Description', style: TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.6))),
                    const SizedBox(height: 8),
                    Text(_task!.description!, style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Icon(Icons.calendar_today, color: theme.colorScheme.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Due Date', style: TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.6))),
                        const SizedBox(height: 4),
                        Text(_formatDateTime(_task!.dateTime), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _toggleComplete,
            icon: Icon(_task!.isCompleted ? Icons.undo : Icons.check),
            label: Text(_task!.isCompleted ? 'Mark as Pending' : 'Mark as Complete'),
            style: ElevatedButton.styleFrom(
              backgroundColor: _task!.isCompleted ? Colors.orange : Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateStr;
    }
  }
}