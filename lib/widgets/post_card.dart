import 'package:beco/models/user.dart';
import 'package:beco/providers/user_provider.dart';
import 'package:beco/resources/firestore_methods.dart';
import 'package:beco/screens/comments_screen.dart';
import 'package:beco/utils/colors.dart';
import 'package:beco/utils/utils.dart';
import 'package:beco/widgets/like_animation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final snapData;
  const PostCard({
    super.key,
    this.snapData,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;
  int commentLen = 0;

  @override
  void initState() {
    super.initState();
    getComments();
  }

  getComments() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.snapData['postId'])
          .collection('comments')
          .get();

      commentLen = snap.docs.length;
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                .copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                    widget.snapData['profImage'],
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
                          widget.snapData['username'],
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
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shrinkWrap: true,
                          children: ['Delete']
                              .map((e) => InkWell(
                                  onTap: () async {
                                    await FirestoreMethods()
                                        .deletePost(widget.snapData['postId']);
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 16),
                                      child: Text(e))))
                              .toList(),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),

            // IMAGE SECTION
          ),
          GestureDetector(
            onDoubleTap: () async {
              await FirestoreMethods().likePost(
                uid: user.uid,
                postId: widget.snapData['postId'],
                likes: widget.snapData['likes'],
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
                    widget.snapData['postUrl'],
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
          ),

          // BUTTONS SECTION
          Row(
            children: [
              LikeAnimation(
                // if user liked the post, show red heart
                isAnimating: widget.snapData['likes'].contains(user.uid),
                smallLike: true, // small heart
                child: IconButton(
                  onPressed: () async {
                    // 작은 하트를 누르면 좋아요를 추가하거나 삭제함
                    await FirestoreMethods().likePost(
                      postId: widget.snapData['postId'],
                      uid: user.uid,
                      likes: widget.snapData['likes'],
                    );
                  },
                  icon: widget.snapData['likes'].contains(user.uid)
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.favorite_border,
                          color: Colors.red,
                        ),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).push(
                  // MaterialPageRoute를 사용하여 CommentsScreen으로 이동
                  MaterialPageRoute(
                    builder: (context) => CommentsScreen(
                      postId: widget.snapData['postId'],
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
                widget.snapData['likes'].length == 0
                    ? Container()
                    : DefaultTextStyle(
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(fontWeight: FontWeight.w800),
                        child: Text(
                          widget.snapData['likes'].length == 1
                              ? '${widget.snapData['likes'].length} like'
                              : '${widget.snapData['likes'].length} likes',
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
                          text: widget.snapData['username'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: ' ${widget.snapData['description']}',
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
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
                      widget.snapData['datePublished'].toDate(),
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
}
