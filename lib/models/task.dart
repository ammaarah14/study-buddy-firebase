import 'package:cloud_firestore/cloud_firestore.dart';

class StudyTask {
  const StudyTask({
    required this.id,
    required this.title,
    required this.subject,
    required this.dueDate,
    required this.priority,
    required this.completed,
  });

  final String id;
  final String title;
  final String subject;
  final DateTime? dueDate;
  final String priority;
  final bool completed;

  factory StudyTask.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    final timestamp = data['dueDate'];
    return StudyTask(
      id: doc.id,
      title: data['title'] as String? ?? 'Untitled task',
      subject: data['subject'] as String? ?? 'General',
      dueDate: timestamp is Timestamp ? timestamp.toDate() : null,
      priority: data['priority'] as String? ?? 'Medium',
      completed: data['completed'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() => {
        'title': title,
        'subject': subject,
        'dueDate': dueDate == null ? null : Timestamp.fromDate(dueDate!),
        'priority': priority,
        'completed': completed,
      };
}
