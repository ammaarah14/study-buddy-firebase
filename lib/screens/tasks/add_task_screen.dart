import 'package:flutter/material.dart';

import '../../services/firestore_service.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _title = TextEditingController();
  final _subject = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String _priority = 'Medium';
  DateTime? _dueDate;
  bool _saving = false;

  @override
  void dispose() {
    _title.dispose();
    _subject.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _saving = true);

    try {
      await FirestoreService().addTask(
        title: _title.text,
        subject: _subject.text,
        dueDate: _dueDate,
        priority: _priority,
      );

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not save task: $e'),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Add task'),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              TextFormField(
                controller: _title,
                decoration: const InputDecoration(
                  labelText: 'Task title',
                ),
                validator: (v) =>
                    v == null || v.trim().isEmpty
                        ? 'Enter a task title.'
                        : null,
              ),
              const SizedBox(height: 14),
              TextField(
                controller: _subject,
                decoration: const InputDecoration(
                  labelText: 'Subject (optional)',
                  prefixIcon: Icon(Icons.menu_book_outlined),
                ),
              ),
              const SizedBox(height: 14),
              DropdownButtonFormField<String>(
                initialValue: _priority,
                decoration: const InputDecoration(
                  labelText: 'Priority',
                ),
                items: const [
                  'Low',
                  'Medium',
                  'High',
                ]
                    .map(
                      (p) => DropdownMenuItem(
                        value: p,
                        child: Text(p),
                      ),
                    )
                    .toList(),
                onChanged: (v) {
                  setState(() => _priority = v ?? 'Medium');
                },
              ),
              const SizedBox(height: 14),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  _dueDate == null
                      ? 'No due date'
                      : 'Due ${_dueDate!.day}/${_dueDate!.month}/${_dueDate!.year}',
                ),
                leading: const Icon(Icons.calendar_today_outlined),
                trailing: TextButton(
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                      initialDate: _dueDate ?? DateTime.now(),
                    );

                    if (picked != null) {
                      setState(() => _dueDate = picked);
                    }
                  },
                  child: const Text('Choose'),
                ),
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _saving ? null : _save,
                child: Padding(
                  padding: const EdgeInsets.all(13),
                  child: _saving
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Text('Save task'),
                ),
              ),
            ],
          ),
        ),
      );
}