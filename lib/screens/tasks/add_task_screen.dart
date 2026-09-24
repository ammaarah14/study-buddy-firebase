import 'package:flutter/material.dart';
import '../../services/firestore_service.dart';
import '../../theme/study_buddy_theme.dart';
import '../../widgets/whimsical_background.dart';
import '../../widgets/whimsical_card.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});
  @override State<AddTaskScreen> createState() => _AddTaskScreenState();
}
class _AddTaskScreenState extends State<AddTaskScreen> {
  final _title = TextEditingController(); final _subject = TextEditingController(); final _formKey = GlobalKey<FormState>();
  String _priority = 'Medium'; DateTime? _dueDate; bool _saving = false;
  @override void dispose() { _title.dispose(); _subject.dispose(); super.dispose(); }
  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return; setState(() => _saving = true);
    try { await FirestoreService().addTask(title: _title.text, subject: _subject.text, dueDate: _dueDate, priority: _priority); if (mounted) Navigator.pop(context); }
    catch (e) { if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Could not save task: $e'))); }
    finally { if (mounted) setState(() => _saving = false); }
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('A new little goal ✦')),
    body: WhimsicalBackground(child: Form(key: _formKey, child: ListView(padding: const EdgeInsets.fromLTRB(20, 8, 20, 35), children: [
      const HandDrawnLabel('Let’s plan it!'), const SizedBox(height: 18),
      WhimsicalCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Task details', style: Theme.of(context).textTheme.titleMedium), const SizedBox(height: 14),
        TextFormField(controller: _title, decoration: const InputDecoration(labelText: 'What are you studying?', prefixIcon: Icon(Icons.auto_awesome_rounded)), validator: (v) => v == null || v.trim().isEmpty ? 'Enter a task title.' : null),
        const SizedBox(height: 14), TextField(controller: _subject, decoration: const InputDecoration(labelText: 'Subject (optional)', prefixIcon: Icon(Icons.menu_book_rounded))),
        const SizedBox(height: 14), DropdownButtonFormField<String>(initialValue: _priority, decoration: const InputDecoration(labelText: 'Priority', prefixIcon: Icon(Icons.star_rounded)), items: const ['Low','Medium','High'].map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(), onChanged: (v) => setState(() => _priority = v ?? 'Medium')),
        const SizedBox(height: 8),
        ListTile(contentPadding: EdgeInsets.zero, leading: const Icon(Icons.calendar_month_rounded, color: StudyBuddyColors.deepRose), title: Text(_dueDate == null ? 'No due date' : 'Due ${_dueDate!.day}/${_dueDate!.month}/${_dueDate!.year}'), subtitle: const Text('Give your future self a gentle deadline'), trailing: TextButton(onPressed: () async { final picked = await showDatePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime(2100), initialDate: _dueDate ?? DateTime.now()); if (picked != null) setState(() => _dueDate = picked); }, child: const Text('Choose'))),
      ])), const SizedBox(height: 18),
      FilledButton.icon(onPressed: _saving ? null : _save, icon: const Icon(Icons.favorite_rounded), label: _saving ? const SizedBox(height: 22, width: 22, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Text('Save my task')),
    ]))),
  );
}
