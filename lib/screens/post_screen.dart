import 'package:beco/utils/colors.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatelessWidget {
  final snap;
  const PostScreen({super.key, this.snap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text('Post'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Center(
              child: Text('Post by ${snap['username']}'),
            )
          ],
        ),
      ),
    );
  }
}
