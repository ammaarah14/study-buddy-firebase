import 'package:cloud_firestore/cloud_firestore.dart';

class StudySubject {
  const StudySubject({
    required this.id,
    required this.name,
    required this.colorValue,
  });

  final String id;
  final String name;
  final int colorValue;

  factory StudySubject.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return StudySubject(
      id: doc.id,
      name: data['name'] as String? ?? 'Subject',
      colorValue: data['colorValue'] as int? ?? 0xFF4F6F52,
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'colorValue': colorValue,
      };
}
