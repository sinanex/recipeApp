import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  CollectionReference fireStore = FirebaseFirestore.instance.collection(
    'users',
  );
  Future<String?> loginUser(String email, String password) async {
    log('logginnnnn........');
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      log("login success ${userCredential.user?.email}");
      return 'login success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
    }
  }

  Future<String?> registerUser(
    String email,
    String password,
    String name,
    String imgUrl,
  ) async {
    log('regiser......');
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      String uid = userCredential.user!.uid;
      fireStore.doc(uid).set({
        'image': imgUrl,
        'email': email,
        'uid': uid,
        'name': name,
      });

      return 'reg success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      } else {
        log(e.toString());
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<Map<String, dynamic>> getUserData() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
         final User? user =  FirebaseAuth.instance.currentUser;
         if(user!=null){
          log('user found');
         }else{
          log('user not get');
         }

    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (userDoc.exists) {
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      log("User Name: ${userData['name']}");
      return userData;
    } else {
      log("User data not found!");
    }
    return {};
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> logoutUser() async {
    try {
      await _auth.signOut();
      print("User successfully logged out.");
    } catch (e) {
      print("Error logging out: $e");
    }
  }
}
