import 'package:cloud_firestore/cloud_firestore.dart';

class PhotographerModel {
  late String? id;
  late String? uid;
  late String? cost;
  late String? location;
  late bool? status;
  late DocumentReference<Map<String, dynamic>>? user;
  late String? category;
  late List<String>? url;
  late bool? disabled;

  PhotographerModel({
    this.id,
    this.uid,
    this.cost,
    this.location,
    this.status,
    this.user,
    this.category,
    this.url,
    this.disabled,
  });

  static List<T> toList<T>(dynamic list) {
    if (list == null) return [];
    final List<T> newList = [];
    for (var l in list) {
      newList.add(l);
    }
    return newList;
  }

  factory PhotographerModel.fromJSON(dynamic json) {
    return PhotographerModel(
      id: json["id"],
      uid: json["uid"],
      cost: json["cost"],
      location: json["location"],
      status: json["status"] ?? false,
      user: json["User"],
      category: json["category"],
      url: toList<String>(json["url"]),
      disabled: json["disabled"] ?? false,
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
      "url": url,
      "disabled": disabled,
    };
  }
}
