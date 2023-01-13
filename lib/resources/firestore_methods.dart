import 'package:beco/models/post.dart';
import 'package:beco/resources/storage_method.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
      String postId = Uuid().v1();

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

  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection("posts").doc(postId).delete();
    } catch (e) {
      print(e.toString());
    }
  }
}
