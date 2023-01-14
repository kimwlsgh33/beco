import 'package:beco/utils/colors.dart';
import 'package:flutter/material.dart';

class IconInButton extends StatelessWidget {
  final Function()? onPressed;
  final Color backgroundColor;
  final Color borderColor;
  final Icon icon;
  final EdgeInsets padding;

  const IconInButton({
    super.key,
    required this.icon,
    this.backgroundColor = mobileBackgroundColor,
    this.onPressed,
    required this.borderColor,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: backgroundColor),
        ),
      ),
      child: Container(
        padding: padding,
        child: Center(child: icon),
      ),
    );
  }
}
