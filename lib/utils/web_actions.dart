import 'package:beco/utils/colors.dart';
import 'package:flutter/material.dart';

List<IconButton> webActions({page, navigationTapped}) => [
      IconButton(
        onPressed: () => navigationTapped(0),
        icon: Icon(
          Icons.home,
          color: page == 0 ? primaryColor : secondaryColor,
        ),
      ),
      IconButton(
        onPressed: () => navigationTapped(1),
        icon: Icon(
          Icons.search,
          color: page == 1 ? primaryColor : secondaryColor,
        ),
      ),
      IconButton(
        onPressed: () => navigationTapped(2),
        icon: Icon(
          Icons.add_a_photo,
          color: page == 2 ? primaryColor : secondaryColor,
        ),
      ),
      IconButton(
        onPressed: () => navigationTapped(3),
        icon: Icon(
          Icons.favorite,
          color: page == 3 ? primaryColor : secondaryColor,
        ),
      ),
      IconButton(
        onPressed: () => navigationTapped(4),
        icon: Icon(
          Icons.person,
          color: page == 4 ? primaryColor : secondaryColor,
        ),
      ),
    ];
