import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/firestore_service.dart';
import '../theme/study_buddy_theme.dart';
import 'whimsical_card.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.task});
  final StudyTask task;

  @override
  Widget build(BuildContext context) {
    final priority = task.priority == 'High'
        ? StudyBuddyColors.red
        : task.priority == 'Low'
            ? StudyBuddyColors.sage
            : StudyBuddyColors.butter;

    return WhimsicalCard(
      color: StudyBuddyColors.paper,
      padding: const EdgeInsets.fromLTRB(17, 13, 8, 13),
      doodle: true,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => FirestoreService().setTaskCompleted(task.id, !task.completed),
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: task.completed ? StudyBuddyColors.deepRose : Colors.transparent,
                border: Border.all(color: StudyBuddyColors.deepRose, width: 1.8),
                borderRadius: BorderRadius.circular(3),
              ),
              child: task.completed ? const Icon(Icons.check_rounded, size: 19, color: Colors.white) : null,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: task.completed ? StudyBuddyColors.mutedInk : StudyBuddyColors.ink,
                    decoration: task.completed ? TextDecoration.lineThrough : null,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${task.subject}${task.dueDate == null ? '' : '  ·  Due ${task.dueDate!.day}/${task.dueDate!.month}'}',
                  style: const TextStyle(fontSize: 13, color: StudyBuddyColors.mutedInk),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            children: [
              Container(width: 10, height: 10, decoration: BoxDecoration(color: priority, shape: BoxShape.circle)),
              PopupMenuButton<String>(
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.more_vert_rounded, color: StudyBuddyColors.deepRose),
                onSelected: (v) { if (v == 'delete') FirestoreService().deleteTask(task.id); },
                itemBuilder: (_) => const [PopupMenuItem(value: 'delete', child: Text('Delete task'))],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
