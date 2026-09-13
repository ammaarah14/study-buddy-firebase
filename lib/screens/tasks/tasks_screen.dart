import 'package:flutter/material.dart';

import '../../models/task.dart';
import '../../services/firestore_service.dart';
import '../../widgets/task_tile.dart';
import 'add_task_screen.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final db = FirestoreService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const AddTaskScreen(),
          ),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Add task'),
      ),
      body: StreamBuilder<List<StudyTask>>(
        stream: db.watchTasks(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Could not load tasks.'),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final tasks = snapshot.data!;

          if (tasks.isEmpty) {
            return const Center(
              child: Text('No tasks yet. Add your first one.'),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: tasks.length,
            separatorBuilder: (_, _) => const SizedBox(height: 10),
            itemBuilder: (_, i) => TaskTile(
              task: tasks[i],
            ),
          );
        },
      ),
    );
  }
}