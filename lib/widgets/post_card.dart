import 'package:beco/cubits/auth_cubit.dart';
import 'package:beco/models/menu.dart';
import 'package:beco/models/user.dart';
import 'package:beco/resources/firestore_methods.dart';
import 'package:beco/screens/comments_screen.dart';
import 'package:beco/screens/profile_screen.dart';
import 'package:beco/utils/colors.dart';
import 'package:beco/utils/global_variables.dart';
import 'package:beco/utils/utils.dart';
import 'package:beco/widgets/like_animation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class PostCard extends StatefulWidget {
  final postData;
  const PostCard({
    super.key,
    this.postData,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;
  int commentLen = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: width > webScreenSize ? secondaryColor : mobileBackgroundColor,
        ),
        color: mobileBackgroundColor,
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                .copyWith(right: 0),
            child: Row(
              children: [
                InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(
                        uid: widget.postData.uid,
                      ),
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(
                      widget.postData.profImage,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.postData.username,
                          style: const TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    iconMenuModal(
                      context: context,
                      list: [
                        Menu(
                            title: 'Add to favorite',
                            icon: Icons.star_border_rounded),
                        Menu(title: 'Cancle follow', icon: Icons.person_remove),
                      ],
                    );
                  },
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),

            // IMAGE SECTION
          ),
          BlocBuilder<AuthCubit, User>(builder: (context, user) {
            return GestureDetector(
              onDoubleTap: () async {
                await FirestoreMethods().likePost(
                  uid: user.uid,
                  postId: widget.postData.postId,
                  likes: widget.postData.likes,
                );
                setState(() {
                  isLikeAnimating = true;
                });
                Future.delayed(const Duration(milliseconds: 500), () {
                  setState(() {
                    isLikeAnimating = false;
                  });
                });
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: double.infinity,
                    child: Image.network(
                      widget.postData.postUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // 투명도를 조절하여 좋아요 애니메이션을 보여줌
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    // isLikeAnimating이 true일 때만 애니메이션을 보여줌 ( 투명도 1 )
                    opacity: isLikeAnimating ? 1 : 0,
                    child: LikeAnimation(
                      isAnimating: isLikeAnimating,
                      duration: const Duration(
                        milliseconds: 400,
                      ),
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 120,
                      ),
                      onEnd: () {
                        // animation이 끝나면 isLikeAnimating을 false로 변경
                        setState(() {
                          isLikeAnimating = false;
                        });
                      },
                    ),
                  ),
                ],
              ),
            );
          }),

          // BUTTONS SECTION
          Row(
            children: [
              BlocBuilder<AuthCubit, User>(builder: (context, user) {
                return LikeAnimation(
                  // if user liked the post, show red heart
                  isAnimating: widget.postData.likes.contains(user.uid),
                  smallLike: true, // small heart
                  child: IconButton(
                    onPressed: () async {
                      // 작은 하트를 누르면 좋아요를 추가하거나 삭제함
                      await FirestoreMethods().likePost(
                        postId: widget.postData.postId,
                        uid: user.uid,
                        likes: widget.postData.likes,
                      );
                    },
                    icon: widget.postData.likes.contains(user.uid)
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : const Icon(
                            Icons.favorite_border,
                            color: Colors.red,
                          ),
                  ),
                );
              }),
              IconButton(
                onPressed: () => Navigator.of(context).push(
                  // MaterialPageRoute를 사용하여 CommentsScreen으로 이동
                  MaterialPageRoute(
                    builder: (context) => CommentsScreen(
                      postId: widget.postData.postId,
                    ),
                  ),
                ),
                icon: const Icon(Icons.comment_outlined),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.send),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.bookmark_border),
                  ),
                ),
              ),
            ],
          ),

          // DESCRIPTION SECTION

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // DefaultTextStyle : https://api.flutter.dev/flutter/painting/DefaultTextStyle-class.html
                widget.postData.likes.length == 0
                    ? Container()
                    : DefaultTextStyle(
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(fontWeight: FontWeight.w800),
                        child: Text(
                          widget.postData.likes.length == 1
                              ? '${widget.postData.likes.length} like'
                              : '${widget.postData.likes.length} likes',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 8),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(color: primaryColor),
                      children: [
                        TextSpan(
                          text: widget.postData.username,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: ' ${widget.postData.description}',
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CommentsScreen(
                        postId: widget.postData.postId,
                      ),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      'View all $commentLen comments',
                      style: const TextStyle(
                        fontSize: 16,
                        color: secondaryColor,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    // from intl package, DateFormat : https://pub.dev/packages/intl
                    // format timestamp to date
                    // DateFormat('dd MMM yyyy').format(
                    DateFormat.yMMMd().format(
                      widget.postData.datePublished,
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      color: secondaryColor,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  getComments() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.postData.postId)
          .collection('comments')
          .get();

      commentLen = snap.docs.length;
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getComments();
  }
}
