import 'package:beco/models/user.dart' as model;
import 'package:beco/resources/storage_method.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

class AuthMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getCurrentUser() async {
  // getCurrentUser() async {
    // firebase_auth 에서 현재 로그인된 유저 정보를 가져옴
    User firebaseUser = _auth.currentUser!;

    // firestore에 저장된 유저의 정보를 가져옴
    DocumentSnapshot snap =
        await _firestore.collection('users').doc(firebaseUser.uid).get();

    // snapshot을 model.User로 변환하는 메소드를 사용
    return model.User.fromSnapshot(snap);

    // return model.User.fromJson(documentSnapshot.data() as Map<String, dynamic>);
  }

  // Future signInWithEmailAndPassword(String email, String password) async {
  //   try {
  //     UserCredential result = await _auth.signInWithEmailAndPassword(
  //         email: email, password: password);
  //     User? firebaseUser = result.user;
  //     return firebaseUser;
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Something went wrong";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file.isNotEmpty) {
        // Create a new user
        UserCredential result = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        User? firebaseUser = result.user;

        String photoUrl = await StorageMethods().uploadImageToStorage(
          childName: "profilePics",
          file: file,
          isPost: false,
        );

        // print(firebaseUser!.uid);

        // Create a new document for the user with the uid ( json )
        model.User user = model.User(
          uid: firebaseUser!.uid,
          email: email,
          username: username,
          bio: bio,
          photoUrl: photoUrl,
          followers: [],
          following: [],
        );

        // add user to firestore
        // 1. create or update users collection
        // 2. create or find user document
        // 3. add user data to user document
        await _firestore
            .collection("users")
            .doc(firebaseUser.uid)
            .set(user.toJson());

        // if use add() instead of set(), it will create a new document with a random id ( not uid )
        // await _firestore.collection("users").add({
        //   "uid": firebaseUser.uid,
        //   "email": email,
        //   "username": username,
        //   "bio": bio,
        //   // "profileImage": file,
        //   "followers": [],
        //   "following": [],
        // });

        res = "success";
      } else {
        res = "Please fill all the fields";
      }
    } on FirebaseAuthException catch (e) {
      // catch firebase auth errors
      if (e.code == 'weak-password') {
        res = "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        res = "The account already exists for that email.";
      } else if (e.code == 'invalid-email') {
        res = "The email is invalid.";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  // logging in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Something went wrong";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // Create a new user
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        res = "success";
      } else {
        res = "Please fill all the fields";
      }
    } on FirebaseAuthException catch (e) {
      // catch firebase auth errors
      if (e.code == 'user-not-found') {
        res = "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        res = "Wrong password provided for that user.";
      } else if (e.code == 'invalid-email') {
        res = "The email is invalid.";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
