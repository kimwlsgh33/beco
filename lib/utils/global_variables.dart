import 'package:beco/screens/add_post_screen.dart';
import 'package:beco/screens/feed_screen.dart';
import 'package:flutter/material.dart';

const webScreenSize = 600;

// 글로벌변수로, 화면을 지정
const homeScreenItems = [
  FeedScreen(),
  Text('search'),
  AddPostScreen(),
  Text('notification'),
  Text('profile'),
];
