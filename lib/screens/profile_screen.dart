import 'package:beco/resources/auth_method.dart';
import 'package:beco/utils/colors.dart';
import 'package:beco/widgets/follow_button.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            'username',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: false,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          NetworkImage('https://picsum.photos/200'),
                    ),
                    const SizedBox(width: 50),
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildStatColumn('Posts', 0),
                          buildStatColumn('Followers', 0),
                          buildStatColumn('Following', 0),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'username',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 1),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Some bio',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FollowButton(
                        backgroundColor: Colors.grey.shade800,
                        borderColor: Colors.grey.shade800,
                        text: 'Edit Profile',
                        textColor: primaryColor,
                        function: () {},
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.supervised_user_circle),
                      ),
                      // FollowButton(
                      //   backgroundColor: Colors.grey,
                      //   borderColor: Colors.grey,
                      //   text: 'UnFollow',
                      //   textColor: primaryColor,
                      // )
                    ],
                  ),
                )
              ],
            ),
          )
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
}
