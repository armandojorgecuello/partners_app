import 'package:flutter/material.dart';

/// Colors extracted from the app's previously inline literals so every
/// feature references one source instead of repeating hex codes.
class AppColors {
  AppColors._();

  static const primary = Color(0xFF0F9D75);
  static const primaryDark = Color(0xFF0B6E54);
  static const scaffoldLight = Color(0xFFF7F9F8);

  // Most authenticated pages render their own dark surface regardless of the
  // ambient (light) MaterialApp theme — preserved as-is, not redesigned.
  static const pageDark = Color(0xFF393939);
  static const cardDark = Color(0xFF282828);

  static const white = Colors.white;
  static const white70 = Colors.white70;
}
