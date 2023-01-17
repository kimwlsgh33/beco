import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String username;
  final String bio;
  final String photoUrl;
  final List followers;
  final List following;
  final int focusTime;
  final int restTime;

  const User({
    required this.email,
    required this.uid,
    required this.username,
    required this.bio,
    required this.photoUrl,
    required this.followers,
    required this.following,
    required this.focusTime,
    required this.restTime,
  });

  // convert json to User ( for api )
  User.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        uid = json['uid'],
        username = json['username'],
        bio = json['bio'],
        photoUrl = json['photoUrl'],
        followers = json['followers'],
        following = json['following'],
        focusTime = json['focusTime'],
        restTime = json['restTime'];

  // convert User to json ( for firebase )
  Map<String, dynamic> toJson() => {
        'email': email,
        'uid': uid,
        'username': username,
        'bio': bio,
        'photoUrl': photoUrl,
        'followers': followers,
        'following': following,
        'focusTime': focusTime,
        'restTime': restTime,
      };

  // convert DocumentSnapshot to User ( for firebase )
  static User fromSnap(DocumentSnapshot snap) {
    var data = snap.data() as Map<String, dynamic>;

    return User(
      email: data['email'],
      uid: data['uid'],
      username: data['username'],
      bio: data['bio'],
      photoUrl: data['photoUrl'],
      followers: data['followers'],
      following: data['following'],
      focusTime: data['focusTime'],
      restTime: data['restTime'],
    );
  }

  // copyWith is a method that returns a new instance of the User class
}
