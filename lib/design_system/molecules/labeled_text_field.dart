import 'package:flutter/material.dart';
import 'package:partners_app/design_system/atoms/app_text.dart';
import 'package:partners_app/design_system/atoms/app_text_field.dart';

/// Label + [AppTextField], replacing the repeated "title + input" pairs in
/// new_task_page.dart and profile_page.dart.
class LabeledTextField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final String? hintText;
  final String? initialValue;
  final bool obscureText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;

  const LabeledTextField({
    super.key,
    required this.label,
    this.controller,
    this.hintText,
    this.initialValue,
    this.obscureText = false,
    this.keyboardType,
    this.maxLines = 1,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(label, variant: AppTextVariant.label),
        const SizedBox(height: 4),
        AppTextField(
          controller: controller,
          hintText: hintText,
          initialValue: initialValue,
          obscureText: obscureText,
          keyboardType: keyboardType,
          maxLines: maxLines,
          onChanged: onChanged,
          validator: validator,
        ),
      ],
    );
  }
}
