import 'package:cloud_firestore/cloud_firestore.dart';

class GetNotesModel {
  String? title;
  String? description;
  DateTime? createdAt;
  String? docId;

  GetNotesModel({
    this.title,
    this.description,
    this.createdAt,
    this.docId,
  });

  factory GetNotesModel.fromMap(String docId, Map<String, dynamic> map) {
    DateTime? date = (map['created_at'] as Timestamp?)?.toDate();
    return GetNotesModel(
      docId: docId,
      title: map['title'],
      description: map['description'],
      createdAt: date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'created_at': createdAt,
    };
  }
}
