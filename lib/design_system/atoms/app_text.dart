import 'package:flutter/material.dart';
import 'package:partners_app/core/theme/app_text_styles.dart';

enum AppTextVariant { label, subtitle, body, emphasis }

/// Typography atom backed by [AppTextStyles] so feature pages stop repeating
/// `TextStyle(color: Colors.white, fontFamily: 'Sans...')` literals.
class AppText extends StatelessWidget {
  final String text;
  final AppTextVariant variant;
  final TextAlign? textAlign;
  final TextStyle? styleOverride;

  const AppText(
    this.text, {
    super.key,
    this.variant = AppTextVariant.body,
    this.textAlign,
    this.styleOverride,
  });

  @override
  Widget build(BuildContext context) {
    final base = switch (variant) {
      AppTextVariant.label => AppTextStyles.label,
      AppTextVariant.subtitle => AppTextStyles.subtitle,
      AppTextVariant.body => AppTextStyles.body,
      AppTextVariant.emphasis => AppTextStyles.emphasis,
    };
    return Text(text, textAlign: textAlign, style: base.merge(styleOverride));
  }
}
