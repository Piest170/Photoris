import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late String? userid;
  late String? email;
  late String? password;
  late String? fullname;
  late String? photo;
  late String? phone;
  late String? lineId;
  late String? website;
  late String? detail;
  late String? status;

  UserModel({
    this.userid,
    this.email,
    this.password,
    this.fullname,
    this.photo,
    this.phone,
    this.lineId,
    this.website,
    this.detail,
    this.status,
  });

  factory UserModel.fromJSON(dynamic json) {
    return UserModel(
      userid: json["userid"],
      email: json["email"],
      password: json["password"],
      fullname: json["fullname"],
      photo: json["photo"],
      phone: json["phone"],
      lineId: json["lineId"],
      website: json["website"],
      detail: json["detial"],
      status: json["status"],
    );
  }

  toJSON() {
    return {
      "userid": this.userid,
      "email": this.email,
      "password": this.password,
      "fullname": this.fullname,
      "photo": this.photo,
      "phone": this.phone,
      "lineId": this.lineId,
      "website": this.website,
      "detail": this.detail,
      "status": this.status,
    };
  }
}

class UserService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('User');

  createUser(UserModel user) async {
    await _firestore.collection("User").doc(user.userid).set({
      "userid": user.userid,
      "fullname": user.fullname,
      "email": user.email,
      "password": user.password,
      "photo": user.photo,
      "phone": user.phone,
      "lineId": user.lineId,
      "website": user.website,
      "detail": user.detail
    });
  }
}
