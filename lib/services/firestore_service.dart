import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/subject.dart';
import '../models/task.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get _uid => _auth.currentUser!.uid;

  CollectionReference<Map<String, dynamic>> get _tasks =>
      _db.collection('users').doc(_uid).collection('tasks');

  CollectionReference<Map<String, dynamic>> get _subjects =>
      _db.collection('users').doc(_uid).collection('subjects');

  Stream<List<StudyTask>> watchTasks() => _tasks
      .orderBy('completed')
      .snapshots()
      .map((snapshot) => snapshot.docs.map(StudyTask.fromDocument).toList());

  Stream<List<StudySubject>> watchSubjects() => _subjects
      .orderBy('name')
      .snapshots()
      .map((snapshot) => snapshot.docs.map(StudySubject.fromDocument).toList());

  Future<void> createProfile(User user) async {
    final ref = _db.collection('users').doc(user.uid);
    await ref.set({
      'email': user.email,
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<void> addTask({
    required String title,
    required String subject,
    required DateTime? dueDate,
    required String priority,
  }) async {
    await _tasks.add({
      'title': title.trim(),
      'subject': subject.trim().isEmpty ? 'General' : subject.trim(),
      'dueDate': dueDate == null ? null : Timestamp.fromDate(dueDate),
      'priority': priority,
      'completed': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> setTaskCompleted(String id, bool completed) =>
      _tasks.doc(id).update({'completed': completed});

  Future<void> deleteTask(String id) => _tasks.doc(id).delete();

  Future<void> addSubject(String name) async {
    final cleanName = name.trim();
    if (cleanName.isEmpty) return;
    await _subjects.add({
      'name': cleanName,
      'colorValue': 0xFF4F6F52,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteSubject(String id) => _subjects.doc(id).delete();
}
