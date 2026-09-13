import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/firestore_service.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.task}); final StudyTask task;
  @override
  Widget build(BuildContext context) {
    final color = task.priority == 'High' ? Colors.red : task.priority == 'Low' ? Colors.green : Colors.orange;
    return Card(child: ListTile(contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5), leading: Checkbox(value: task.completed, onChanged: (value) => FirestoreService().setTaskCompleted(task.id, value ?? false)), title: Text(task.title, style: TextStyle(fontWeight: FontWeight.w600, decoration: task.completed ? TextDecoration.lineThrough : null)), subtitle: Text('${task.subject}${task.dueDate == null ? '' : ' • Due ${task.dueDate!.day}/${task.dueDate!.month}'}'), trailing: Row(mainAxisSize: MainAxisSize.min, children: [Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)), PopupMenuButton<String>(onSelected: (value) { if (value == 'delete') FirestoreService().deleteTask(task.id); }, itemBuilder: (_) => const [PopupMenuItem(value: 'delete', child: Text('Delete'))])])));
  }
}
