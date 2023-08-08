import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //instance of auth
  final firebaseAuth = FirebaseAuth.instance;

  //insatnce of firestore
  final firestore = FirebaseFirestore.instance;

  //login
  Future<UserCredential> signInWithEmailandPassword(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      //add new document for the user in users collection if it doesn't already exists
      await firestore.collection("users").doc(userCredential.user!.uid).set(
        {
          "uid": userCredential.user!.uid,
          "email": email,
          "password": password,
        },
        SetOptions(merge: true),
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //register
  Future<UserCredential> registerUserWithEmailandPassword(
      String fullname, String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
     await firestore.collection("users").doc(userCredential.user!.uid).set({
        "uid": userCredential.user!.uid,
        "fullName": fullname,
        "email": email,
        "password": password,
      });
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //logout
  Future signOut() async {
    return await firebaseAuth.signOut();
  }
}
