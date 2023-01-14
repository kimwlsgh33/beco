import 'package:beco/utils/colors.dart';
import 'package:flutter/material.dart';

class IconInButton extends StatelessWidget {
  final Function()? onPressed;
  final Color backgroundColor;
  final Color borderColor;
  final IconData icon;
  final Color iconColor;

  const IconInButton({
    super.key,
    required this.icon,
    this.backgroundColor = mobileBackgroundColor,
    this.iconColor = primaryColor,
    this.onPressed,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(color: backgroundColor),
        ),
      ),
      child: Container(
        height: 22,
        alignment: Alignment.center,
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
    );
  }
}
