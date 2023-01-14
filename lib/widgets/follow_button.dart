import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {
  final Function()? onPressed;
  final Color backgroundColor;
  final Color borderColor;
  final String text;
  final Color textColor;
  Icon? icon;

  FollowButton({
    super.key,
    this.backgroundColor = Colors.blueAccent,
    this.borderColor = Colors.blueAccent,
    required this.text,
    this.textColor = Colors.white,
    this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // TextButton : 로딩시 자동으로 disabledColor 적용
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: borderColor),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            icon ?? Container(),
          ],
        ),
      ),
    );
  }
}
