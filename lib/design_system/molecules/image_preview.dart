import 'package:flutter/material.dart';
import 'package:partners_app/core/theme/app_colors.dart';

/// Image-or-placeholder tap target, replacing the conditional preview blocks
/// in new_task_page.dart, start_negociation_task.dart and view_task.dart.
class ImagePreview extends StatelessWidget {
  final String? imageUrl;
  final VoidCallback? onTap;
  final double height;

  const ImagePreview({super.key, this.imageUrl, this.onTap, this.height = 160});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: AppColors.cardDark,
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAlias,
        child: (imageUrl == null || imageUrl!.isEmpty)
            ? const Center(child: Icon(Icons.add_a_photo, color: AppColors.white70, size: 32))
            : Image.network(imageUrl!, fit: BoxFit.cover),
      ),
    );
  }
}
