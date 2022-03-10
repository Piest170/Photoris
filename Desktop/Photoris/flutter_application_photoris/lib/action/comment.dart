import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  late String? id;
  late String? photographerId;
  late String? uid;
  late DocumentReference<Map<String, dynamic>>? user;
  late String? text;
  late DateTime? createdAt;

  CommentModel({
    this.id,
    this.createdAt,
    this.photographerId,
    this.uid,
    this.text,
    this.user,
  });

  factory CommentModel.fromJSON(dynamic json) {
    return CommentModel(
      id: json["id"],
      uid: json["uid"],
      photographerId: json["photographerId"],
      user: json["User"],
      text: json["text"],
      createdAt: json["createdAt"] == null
          ? null
          : (json["createdAt"].toDate() as DateTime),
    );
  }
}
