import 'package:flutter/material.dart';
import 'package:partners_app/core/theme/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const label = TextStyle(color: AppColors.white, fontSize: 14, fontFamily: 'SansRegular');

  static const subtitle = TextStyle(color: AppColors.white, fontFamily: 'SansLightItalic');

  static const body = TextStyle(color: AppColors.white, fontFamily: 'SansRegularlight', fontSize: 14);

  static const emphasis = TextStyle(
    color: AppColors.white,
    fontFamily: 'SansSemiBold',
    fontWeight: FontWeight.bold,
  );
}
