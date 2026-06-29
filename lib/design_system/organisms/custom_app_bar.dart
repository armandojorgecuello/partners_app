import 'package:flutter/material.dart';
import 'package:partners_app/core/theme/app_colors.dart';

/// Relocated from lib/src/widget/appbar_widget.dart, same behavior.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String backLabel;

  const CustomAppBar({super.key, required this.title, required this.backLabel});

  @override
  Size get preferredSize => const Size.fromHeight(55.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Row(
                children: <Widget>[
                  const Icon(Icons.arrow_back_ios, color: AppColors.white),
                  Text(
                    backLabel,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text(title, style: const TextStyle(color: AppColors.white)),
          Expanded(child: Container()),
        ],
      ),
      centerTitle: true,
      backgroundColor: AppColors.primary,
      automaticallyImplyLeading: false,
    );
  }
}
