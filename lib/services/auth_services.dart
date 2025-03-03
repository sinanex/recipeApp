import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  void loginUser(String email, String password) async {
    try {
      FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      log(e.toString());
    }
  }

  void registerUser(String email, String password) async {
    log('regiser......');
    try {
      FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }else{
        log(e.toString());
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
