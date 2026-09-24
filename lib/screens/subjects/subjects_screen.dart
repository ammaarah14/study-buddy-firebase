import 'package:flutter/material.dart';
import '../../models/subject.dart';
import '../../services/firestore_service.dart';
import '../../theme/study_buddy_theme.dart';
import '../../widgets/whimsical_background.dart';
import '../../widgets/whimsical_card.dart';

class SubjectsScreen extends StatelessWidget {
  const SubjectsScreen({super.key});
  Future<void> _add(BuildContext context) async {
    final controller = TextEditingController();
    final name = await showDialog<String>(context: context, builder: (context) => AlertDialog(title: const Text('New subject 🌷'), content: TextField(controller: controller, autofocus: true, decoration: const InputDecoration(labelText: 'Subject name', prefixIcon: Icon(Icons.menu_book_rounded))), actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')), FilledButton(onPressed: () => Navigator.pop(context, controller.text), child: const Text('Add'))]));
    controller.dispose(); if (name != null && name.trim().isNotEmpty) await FirestoreService().addSubject(name);
  }
  @override Widget build(BuildContext context) { final db = FirestoreService(); return Scaffold(appBar: AppBar(title: const Text('My subjects ♡')), floatingActionButton: FloatingActionButton.extended(onPressed: () => _add(context), icon: const Icon(Icons.add_rounded), label: const Text('Add subject')), body: WhimsicalBackground(child: StreamBuilder<List<StudySubject>>(stream: db.watchSubjects(), builder: (context, snapshot) { if (snapshot.hasError) return const Center(child: Text('Could not load subjects.')); if (!snapshot.hasData) return const Center(child: CircularProgressIndicator()); final subjects = snapshot.data!; if (subjects.isEmpty) return const Center(child: WhimsicalCard(child: Text('No subjects yet. Add one to make your study garden bloom! 🌼'))); return ListView.separated(padding: const EdgeInsets.fromLTRB(20, 10, 20, 100), itemCount: subjects.length, separatorBuilder: (_, _) => const SizedBox(height: 11), itemBuilder: (_, i) => _SubjectCard(subject: subjects[i], onDelete: () => db.deleteSubject(subjects[i].id))); })) ); }
}
class _SubjectCard extends StatelessWidget {
  const _SubjectCard({required this.subject, required this.onDelete});
  final StudySubject subject;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final base = Color(subject.colorValue);
    return WhimsicalCard(
      color: StudyBuddyColors.paper,
      padding: const EdgeInsets.fromLTRB(17, 13, 8, 13),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: base.withValues(alpha: .16),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.menu_book_rounded, color: base, size: 29),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(subject.name, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
                const SizedBox(height: 3),
                const Text('A little corner for this subject ✦', style: TextStyle(fontSize: 13, color: StudyBuddyColors.mutedInk)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close_rounded),
            color: StudyBuddyColors.deepRose,
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
