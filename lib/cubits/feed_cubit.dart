import 'package:beco/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedCubit extends Cubit<List<Post>> {
  FeedCubit() : super([]);

  void fetchPosts() async {
    var snap = await FirebaseFirestore.instance
        .collection('posts').orderBy('datePublished', descending: true).get();

    final List<Post> posts = snap.docs.map((e) => Post.fromSnap(e)).toList();
    emit(posts);

    // final List<Post> postsList =
    // emit(postsList);
  }
}
