import 'package:flutter/material.dart';
import 'package:news_api/constants.dart';

void showSnackBarAddFavorites(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    backgroundColor: secondaryColor,
    duration: Duration(seconds: 3),
    content: Text(
      'Added to favorites',
      style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
    ),
  ));
}

void showSnackBarDeleteFavorites(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    backgroundColor: secondaryColor,
    duration: Duration(seconds: 3),
    content: Text(
      'Removed from favorites',
      style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
    ),
  ));
}
