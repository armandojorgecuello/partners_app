import 'package:flutter/material.dart';
import 'package:partners_app/core/theme/app_colors.dart';

/// Settings-style row, replacing the repeated `ListTile` entries in
/// settings_app.dart.
class NavListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const NavListTile({super.key, required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.white),
      title: Text(title, style: const TextStyle(color: AppColors.white)),
      trailing: const Icon(Icons.arrow_forward_ios, color: AppColors.white70, size: 16),
      onTap: onTap,
    );
  }
}
