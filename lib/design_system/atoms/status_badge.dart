import 'package:flutter/material.dart';
import 'package:partners_app/core/theme/app_colors.dart';

/// Generic colored text pill. Feature presentation layers map their own
/// status enum to a label/color (kept out of the shared design system so it
/// doesn't depend on a specific feature's domain types).
class StatusBadge extends StatelessWidget {
  final String label;
  final Color color;

  const StatusBadge({super.key, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
      child: Text(
        label,
        style: const TextStyle(color: AppColors.white, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }
}
