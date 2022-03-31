import 'package:flutter/material.dart';

const primaryColor = Colors.white;
const secondaryColor = Colors.blue;
const iconColor = Colors.black;

const kBoxDecorationShadow = BoxDecoration(color: Colors.white, boxShadow: [
  BoxShadow(
    color: Colors.black12,
    blurRadius: 3.0,
  ),
]);

const kTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 16.0,
);

const kUnderlineInputBorder =
    UnderlineInputBorder(borderSide: BorderSide(color: secondaryColor));
