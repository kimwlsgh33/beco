import 'package:beco/models/pomo_log.dart';
import 'package:beco/models/post.dart';
import 'package:beco/models/wallet.dart';
import 'package:beco/resources/storage_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> updatePomoLog({
    required String uid,
    required int time,
    bool isFocus = true,
  }) async {
    String res = "Something went wrong";
    try {
      QuerySnapshot snap = await _firestore
          .collection('pomodoros')
          .where('uid', isEqualTo: uid)
          .get();
      if (snap.docs.isNotEmpty) {
        DocumentSnapshot doc = snap.docs.first;
        PomoLog log = PomoLog.fromJson(doc.data() as Map<String, dynamic>);
        if (isFocus) {
          log.totalFocus += time;
        } else {
          log.totalBreak += time;
        }
        await doc.reference.update(log.toJson());
        res = "Success";
      } else {
        res = "No log found";
      }
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<String> addComment({
    required String postId,
    required String text,
    required String uid,
    required String username,
    required String profImage,
  }) async {
    String res = "Something went wrong";
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        await _firestore
            .collection("posts")
            .doc(postId)
            .collection("comments")
            .doc(commentId)
            .set(
          {
            "commentId": commentId,
            "text": text,
            "uid": uid,
            "username": username,
            "profImage": profImage,
            "datePublished": DateTime.now(),
          },
        );

        res = "success";
      } else {
        res = "comment is empty";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> addWallet(
    String uid,
  ) async {
    String res = "Something went wrong";
    try {
      String walletId = const Uuid().v1();
      await _firestore
          .collection("users")
          .doc(uid)
          .collection("wallets")
          .doc(walletId)
          .set({
        'walletId': walletId,
        'uid': uid,
        'amount': 0.0,
        'currency': 'USD',
      });

      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection("posts").doc(postId).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> followUser(String uid, String followId) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection("users").doc(uid).get();
      List following = doc.get("following");

      if (following.contains(followId)) {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
        });
        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid])
        });
        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<Wallet>> getWallets() async {
    List<Wallet> wallets = [];
    try {
      var snap = await _firestore
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("wallets")
          .get();

      for (var doc in snap.docs) {
        wallets.add(Wallet.fromJson(doc.data()));
      }

      // print(wallets);

      // await _firestore.collection('users').doc(uid).update({
      //   'wallet': FieldValue.arrayUnion([currency])
      // });
    } catch (e) {
      print(e.toString());
    }

    return wallets;
  }

  Future<void> likePost({
    required String postId,
    required String uid,
    required List likes,
  }) async {
    try {
      if (likes.contains(uid)) {
        // set vs update : set은 전체를 덮어쓰고, update는 일부만 업데이트
        await _firestore.collection("posts").doc(postId).update(
          {
            "likes":
                FieldValue.arrayRemove([uid]), // arrayRemove : 배열에서 특정 값을 제거
          },
        );
      } else {
        await _firestore.collection("posts").doc(postId).update(
          {
            "likes": FieldValue.arrayUnion([uid]), // arrayUnion : 배열에 특정 값을 추가
          },
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // upload
  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String profImage,
  ) async {
    String res = "Something went wrong";
    try {
      String photoUrl = await StorageMethods()
          .uploadImageToStorage(childName: "posts", file: file, isPost: true);

      // v1
      String postId = const Uuid().v1();

      Post post = Post(
        description: description,
        uid: uid,
        username: username,
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        profImage: profImage,
        likes: [],
      );

      _firestore.collection("posts").doc(postId).set(
            post.toJson(),
          );
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
