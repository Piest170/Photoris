import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_photoris/action/user.dart';

class Auth {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;

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
        password: password,
        phone: phone,
        photo:
            'https://firebasestorage.googleapis.com/v0/b/photoris-6b7cc.appspot.com/o/avatar.png?alt=media&token=d7744d6e-143e-46f8-ba35-1871ea5773f5',
        lineId: '-',
        website: '-',
        detail: '-',
        status: "user",
      ));
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return false;
      }
    } catch (e) {
      return false;
      print(e);
    }
  }

  static login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
