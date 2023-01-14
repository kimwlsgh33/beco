import 'package:flutter/material.dart';

class Menu {
  final String title;
  final IconData icon;
  final Function()? onTap;

  Menu({
    required this.title,
    required this.icon,
    this.onTap,
  });
}
