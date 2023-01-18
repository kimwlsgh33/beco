import 'package:beco/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

const webScreenSize = 600;
//==================================================
final darkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: mobileBackgroundColor,
  backgroundColor: kakaoBackgroundColor,
  primaryColor: Colors.white.withOpacity(0.5),
);
//==================================================
final logo = SvgPicture.asset(
  'assets/ic_instagram.svg',
  color: primaryColor,
  height: 32,
);
