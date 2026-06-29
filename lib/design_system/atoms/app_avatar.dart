import 'package:flutter/material.dart';

/// Relocated from lib/src/widget/circle_avatar_widget.dart, same behavior.
class AppAvatar extends StatelessWidget {
  final String? imageUrl;
  final double radius;

  const AppAvatar({super.key, this.imageUrl, required this.radius});

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: const AssetImage('assets/image/no_image.png'),
      );
    }
    return CircleAvatar(radius: radius, backgroundImage: NetworkImage(imageUrl!));
  }
}
