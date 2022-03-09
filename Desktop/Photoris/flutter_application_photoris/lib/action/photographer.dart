import 'package:cloud_firestore/cloud_firestore.dart';

class PhotographerModel {
  late String? id;
  late String? uid;
  late String? cost;
  late String? location;
  late bool? status;
  late DocumentReference<Map<String, dynamic>>? user;
  late String? category;

  PhotographerModel({
    this.id,
    this.uid,
    this.cost,
    this.location,
    this.status,
    this.user,
    this.category,
  });

  factory PhotographerModel.fromJSON(dynamic json) {
    return PhotographerModel(
      id: json["id"],
      uid: json["uid"],
      cost: json["cost"],
      location: json["location"],
      status: json["status"] ?? false,
      user: json["User"],
      category: json["category"],
    );
  }

  toJSON() {
    return {
      "uid": uid,
      "cost": cost,
      "location": location,
      "status": status,
      "User": user,
      "category": category,
    };
  }
}
