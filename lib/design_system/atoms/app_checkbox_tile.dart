import 'package:flutter/material.dart';
import 'package:partners_app/core/theme/app_colors.dart';

/// Replaces the white-on-dark `CheckboxListTile` pattern from new_user.dart
/// and profile_page.dart.
class AppCheckboxTile extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const AppCheckboxTile({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: value,
      onChanged: onChanged,
      activeColor: AppColors.primary,
      title: Text(label, style: const TextStyle(color: AppColors.white)),
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
