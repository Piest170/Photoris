import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userid;
  final String email;
  final String password;
  final String fullname;
  final String photo;
  final String phone;
  final String lineId;
  final String website;
  final String detail;

  UserModel(
      {required this.userid,
      required this.email,
      required this.password,
      required this.fullname,
      required this.photo,
      required this.phone,
      required this.lineId,
      required this.website,
      required this.detail});
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

  // updateUser(UserModel user) async {
  //   await _firestore.collection("User").doc(user.userid).update({
  //     "userid": user.userid,
  //     "fullname": user.fullname,
  //     "email": user.email,
  //     "password": user.password,
  //     "photo": user.photo,
  //     "phone": user.phone,
  //     "lineId": user.lineId,
  //     "website": user.website,
  //     "detail": user.detail
  //   });
  // }
}
