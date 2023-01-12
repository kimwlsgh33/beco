import 'package:beco/providers/user_provider.dart';
import 'package:beco/resources/auth_method.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:beco/models/user.dart' as model;

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  // String username = "";
  //
  // @override
  // void initState() {
  //   super.initState();
  //   getUserName();
  //   AuthMethod().getCurrentUser();
  // }
  //
  // void getUserName() async {
  //   DocumentSnapshot snap = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();
  //
  //   // print(snap.data());
  //   // extract username from snap.data() using the key 'username'
  //   setState(() {
  //     username = (snap.data() as Map<String, dynamic>)['username'];
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // provider를 사용하여 user 정보를 가져옴
    model.User user = Provider.of<UserProvider>(context).getUser;
    UserProvider provider = Provider.of<UserProvider>(context);
    print(provider);
    return Scaffold(
      body: Center(
        child: Text(user.username),
        // child: Text(provider.getUser!.username),

      ),
    );
  }
}
