import 'package:flutter/material.dart';

class Menu {
  final String title;
  final String? subTitle;
  final IconData? icon;
  final Function()? onTap;

  Menu({
    required this.title,
    this.icon,
    this.subTitle,
    this.onTap,
  });
}
