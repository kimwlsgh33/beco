import 'package:beco/utils/colors.dart';
import 'package:beco/utils/global_variables.dart';
import 'package:beco/widgets/post_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor:
          width > webScreenSize ? webBackgroundColor : mobileBackgroundColor,
      appBar: width > webScreenSize
          ? null
          : AppBar(
              backgroundColor: mobileBackgroundColor,
              centerTitle: false,
              title: SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
                height: 32,
              ),
              actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.messenger_outline,
                    ),
                  )
                ]),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        // initialData: initialData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) => Container(
              margin: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: width > webScreenSize ? MediaQuery.of(context).size.width * 0.2 : 0,
              ),
              child: PostCard(
                // 게시글 정보를 PostCard에 전달
                snapData: snapshot.data!.docs[index].data(),
              ),
            ),
          );
        },
      ),
    );
  }
}
