import 'package:flutter/material.dart';
import 'package:partners_app/core/theme/app_colors.dart';

/// Replaces the underline-bordered `TextFormField` styling duplicated across
/// new_task_page, profile_page, send_support, etc.
class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? initialValue;
  final bool obscureText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final Widget? prefix;

  const AppTextField({
    super.key,
    this.controller,
    this.hintText,
    this.initialValue,
    this.obscureText = false,
    this.keyboardType,
    this.maxLines = 1,
    this.onChanged,
    this.validator,
    this.prefix,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: controller == null ? initialValue : null,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLines: maxLines,
      onChanged: onChanged,
      validator: validator,
      style: const TextStyle(color: AppColors.white, fontFamily: 'SansRegular'),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.white70),
        prefixIcon: prefix,
        enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.white)),
        border: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.white)),
        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.white)),
      ),
    );
  }
}
