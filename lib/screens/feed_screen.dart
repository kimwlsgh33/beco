import 'package:beco/cubits/feed_cubit.dart';
import 'package:beco/models/post.dart';
import 'package:beco/utils/colors.dart';
import 'package:beco/utils/global_variables.dart';
import 'package:beco/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class FeedScreen extends StatefulWidget {
  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FeedCubit>().fetchPosts();
  }

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
      body: BlocBuilder<FeedCubit, List<Post>>(
        builder: (context, posts) => ListView.builder(
          itemCount: posts.length,
          itemBuilder: (BuildContext context, int index) => Container(
            margin: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: width > webScreenSize
                  ? MediaQuery.of(context).size.width * 0.2
                  : 0,
            ),
            child: 
            PostCard(
              // 게시글 정보를 PostCard에 전달
              postData: posts[index],
            ),
          ),
        ),
      ),
    );
  }
}
