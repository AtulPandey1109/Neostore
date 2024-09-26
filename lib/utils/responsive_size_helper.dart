import 'package:flutter/material.dart';

class SizeConfig {
  static double screenWidth = 0;
  static double screenHeight = 0;

  // Initialize SizeConfig with the context
  static void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }

  // Define breakpoints for different device sizes
  static bool isMobile() {
    return screenWidth < 600;
  }

  static bool isTablet() {
    return screenWidth >= 600 && screenWidth < 1024;
  }

  static bool isDesktop() {
    return screenWidth >= 1024;
  }

  // Example: height adjustment for responsiveness
  static double getResponsiveHeight(BuildContext context, double percentage) {
    return screenHeight * percentage;
  }
}
