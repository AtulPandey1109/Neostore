import 'package:flutter/material.dart';

const Color kHeadingTextColor = Color(0xff3d3d4e);

const Color kButtonColor = Color(0xFFFF7643);

const Color textColor = Color(0x00c7c7c7);

const Color appBarColor = Colors.white;

const TextStyle kHeaderTextStyle = TextStyle(
    color: Color(0xff3d3d4e),
    fontSize: kHeadingFontSize,
    fontWeight: FontWeight.bold);

const TextStyle kTextButtonStyle = TextStyle(
    color: Color(0xFFFF7643),
    fontWeight: FontWeight.bold);

const TextStyle kHeader2TextStyle = TextStyle(
    color: Color(0xff3d3d4e),
    fontSize: kHeading2FontSize,
    fontWeight: FontWeight.w400);

const TextStyle kHeader3TextStyle = TextStyle(
    color: Color(0xff3d3d4e),
    fontSize: kHeading3FontSize,
    fontWeight: FontWeight.w400);

const TextStyle kHeader4TextStyle = TextStyle(
    color: Color(0xff3d3d4e),
    fontSize: kHeading4FontSize,
    fontWeight: FontWeight.w400);

ButtonStyle kRoundedElevatedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.white70,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    backgroundColor: kButtonColor);
// padding
const double kPaddingSide = 12;

// font sizes

const double kHeadingFontSize = 32;

const double kHeading2FontSize = 24;
const double kHeading3FontSize = 20;
const double kHeading4FontSize = 16;
