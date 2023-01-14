import 'package:beco/models/menu.dart';
import 'package:beco/resources/firestore_methods.dart';
import 'package:beco/utils/colors.dart';
import 'package:beco/utils/utils.dart';
import 'package:beco/widgets/follow_button.dart';
import 'package:beco/widgets/icon_in_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({
    super.key,
    required this.uid,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData, postData;
  int postLen = 0, following = 0, followers = 0;
  bool isFollowing = false, isMe = true, isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              centerTitle: !isMe,
              title: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  userData['username'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              actions: [
                isMe
                    ? Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.add_box_outlined, size: 30),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.menu_rounded, size: 30),
                            onPressed: () {
                              iconMenuModal(
                                context: context,
                                list: [
                                  Menu(
                                    title: 'Report',
                                    icon: Icons.report,
                                    onTap: () {
                                      print('Report');
                                    },
                                  ),
                                  Menu(
                                    title: 'Block',
                                    icon: Icons.block,
                                    onTap: () {
                                      print('Block');
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      )
                    : IconButton(
                        onPressed: () {
                          iconMenuModal(
                            context: context,
                            list: [
                              Menu(
                                title: 'Report',
                                icon: Icons.report,
                                onTap: () {
                                  print('Report');
                                },
                              ),
                              Menu(
                                title: 'Block',
                                icon: Icons.block,
                                onTap: () {
                                  print('Block');
                                },
                              ),
                            ],
                          );
                        },
                        icon: const Icon(Icons.more_vert),
                      ),
              ],
            ),
            body: ListView(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(userData['photoUrl']),
                          ),
                          const SizedBox(width: 50),
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildStatColumn('Posts', postLen),
                                buildStatColumn('Followers', followers),
                                buildStatColumn('Following', following),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          userData['username'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 1),
                        alignment: Alignment.centerLeft,
                        child: Text(userData['bio']),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            isMe
                                ? Expanded(
                                    child: Row(
                                      children: [
                                        FollowButton(
                                          backgroundColor: Colors.grey.shade800,
                                          borderColor: Colors.grey.shade800,
                                          text: 'Edit Profile',
                                          textColor: primaryColor,
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                  )
                                : Expanded(
                                    child: Row(
                                      children: [
                                        isFollowing
                                            ? FollowButton(
                                                backgroundColor:
                                                    Colors.grey.shade800,
                                                borderColor:
                                                    Colors.grey.shade800,
                                                text: 'Following',
                                                textColor: primaryColor,
                                                onPressed: () {
                                                  iconMenuModal(
                                                      title:
                                                          userData['username'],
                                                      context: context,
                                                      list: [
                                                        Menu(
                                                            title: isFollowing
                                                                ? 'Unfollow'
                                                                : 'Follow',
                                                            icon: Icons
                                                                .person_remove,
                                                            onTap: () async {
                                                              await followUser();
                                                              if(!mounted) return;
                                                              Navigator.pop(
                                                                  context);
                                                            }),
                                                        Menu(
                                                          title: 'Mute',
                                                          icon:
                                                              Icons.volume_off,
                                                          onTap: () {
                                                            print('Mute');
                                                          },
                                                        ),
                                                        Menu(
                                                          title: 'Block',
                                                          icon: Icons.block,
                                                          onTap: () {
                                                            print('Block');
                                                          },
                                                        ),
                                                      ]);
                                                },
                                                icon: const Icon(
                                                  Icons.arrow_drop_down_rounded,
                                                  color: primaryColor,
                                                ),
                                              )
                                            : FollowButton(
                                                backgroundColor:
                                                    Colors.blueAccent,
                                                borderColor: Colors.blueAccent,
                                                text: 'Follow',
                                                textColor: primaryColor,
                                                onPressed: followUser,
                                              ),
                                        const SizedBox(width: 5),
                                        FollowButton(
                                          backgroundColor: Colors.grey.shade800,
                                          borderColor: Colors.grey.shade800,
                                          text: 'Message',
                                          textColor: primaryColor,
                                          onPressed: followUser,
                                        ),
                                      ],
                                    ),
                                  ),
                            const SizedBox(width: 5),
                            IconInButton(
                                icon: const Icon(
                                  Icons.person_add_outlined,
                                  color: primaryColor,
                                  size: 20,
                                ),
                                padding: const EdgeInsets.all(8),
                                onPressed: () {},
                                backgroundColor: Colors.grey.shade800,
                                borderColor: mobileBackgroundColor),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(),
                FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('posts')
                      .where('uid', isEqualTo: widget.uid)
                      .get(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return GridView.builder(
                      shrinkWrap: true,
                      physics:
                          const NeverScrollableScrollPhysics(), // GridView is not scrollable
                      itemCount: snapshot.data.docs.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        // 3 items in a row
                        crossAxisCount: 3,
                        childAspectRatio: 1,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Image.network(
                          snapshot.data.docs[index]['postUrl'],
                          fit: BoxFit.cover,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
  }

  Column buildStatColumn(String label, int count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          count.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  followUser() async {
    await FirestoreMethods()
        .followUser(FirebaseAuth.instance.currentUser!.uid, widget.uid);

    if (isFollowing) {
      setState(() {
        isFollowing = false;
        followers--;
      });
    } else {
      setState(() {
        isFollowing = true;
        followers++;
      });
    }
  }

  void getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: widget.uid)
          .get();

      postLen = postSnap.docs.length;
      postData = postSnap.docs;
      following = userSnap.data()!['following'].length;
      followers = userSnap.data()!['followers'].length;
      userData = userSnap.data();
      isFollowing = userSnap
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);
      isMe = widget.uid == FirebaseAuth.instance.currentUser!.uid;
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }
}
