import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String username;
  final String bio;
  final String photoUrl;
  final List followers;
  final List following;

  const User({
    required this.email,
    required this.uid,
    required this.username,
    required this.bio,
    required this.photoUrl,
    required this.followers,
    required this.following,
  });

  // convert json to User ( for api )
  User.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        uid = json['uid'],
        username = json['username'],
        bio = json['bio'],
        photoUrl = json['photoUrl'],
        followers = json['followers'],
        following = json['following'];

  // convert User to json ( for firebase )
  Map<String, dynamic> toJson() => {
        'email': email,
        'uid': uid,
        'username': username,
        'bio': bio,
        'photoUrl': photoUrl,
        'followers': followers,
        'following': following,
      };

  // convert DocumentSnapshot to User ( for firebase )
  static User fromSnapshot(DocumentSnapshot snap) {
    var data = snap.data() as Map<String, dynamic>;

    return User(
      email: data['email'],
      uid: data['uid'],
      username: data['username'],
      bio: data['bio'],
      photoUrl: data['photoUrl'],
      followers: data['followers'],
      following: data['following'],
    );
  }

  // copyWith is a method that returns a new instance of the User class
  User copyWith({
    String? email,
    String? uid,
    String? username,
    String? bio,
    String? photoUrl,
    List? followers,
    List? following,
  }) {
    return User(
      email: email ?? this.email,
      uid: uid ?? this.uid,
      username: username ?? this.username,
      bio: bio ?? this.bio,
      photoUrl: photoUrl ?? this.photoUrl,
      followers: followers ?? this.followers,
      following: following ?? this.following,
    );
  }
}
