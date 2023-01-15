import 'package:beco/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedCubit extends Cubit<List<Post>> {
  FeedCubit() : super([]);

  void fetchPosts() {
    FirebaseFirestore.instance.collection('posts').snapshots().listen((event) {
      final posts = event.docs.map((e) => Post.fromJson(e.data())).toList();
      emit(posts);
    });
  }
}
