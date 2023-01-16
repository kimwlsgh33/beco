import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String username;
  final String postId;
  final DateTime datePublished;
  final String postUrl;
  final String profImage;
  final likes;

  const Post({
    required this.description,
    required this.uid,
    required this.username,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profImage,
    required this.likes,
  });

  Post.fromJson(Map<String, dynamic> json)
      : description = json['description'],
        uid = json['uid'],
        username = json['username'],
        postId = json['postId'],
        datePublished = json['datePublished'],
        postUrl = json['postUrl'],
        profImage = json['profImage'],
        likes = json['likes'];

  Map<String, dynamic> toJson() => {
        'description': description,
        'uid': uid,
        'username': username,
        'postId': postId,
        'datePublished': datePublished,
        'postUrl': postUrl,
        'profImage': profImage,
        'likes': likes,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var data = snap.data() as Map<String, dynamic>;

    return Post(
      description: data['description'],
      uid: data['uid'],
      username: data['username'],
      postId: data['postId'],
      datePublished: data['datePublished'].toDate(),
      postUrl: data['postUrl'],
      profImage: data['profImage'],
      likes: data['likes'],
    );
  }
}
