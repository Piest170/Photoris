import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_photoris/action/user.dart';

class Auth {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static register(
    String email,
    String password,
    String fullname,
    String phone,
  ) async {
    try {
      print("ok");
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await UserService().createUser(UserModel(
          fullname: fullname,
          userid: userCredential.user!.uid,
          email: email,
          phone: phone,
          photo: '',
          lineId: '-',
          website: '-',
          detail: '-'));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  static login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print(userCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
