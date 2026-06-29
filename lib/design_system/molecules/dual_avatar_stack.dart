import 'package:flutter/material.dart';
import 'package:partners_app/design_system/atoms/app_avatar.dart';

/// Two overlapping avatars, duplicated across pay_your_partner.dart,
/// start_negociation_task.dart and review_widget.dart.
class DualAvatarStack extends StatelessWidget {
  final String? backImageUrl;
  final String? frontImageUrl;
  final double radius;

  const DualAvatarStack({
    super.key,
    required this.backImageUrl,
    required this.frontImageUrl,
    this.radius = 28,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: radius * 3,
      height: radius * 2,
      child: Stack(
        children: [
          Positioned(left: 0, child: AppAvatar(imageUrl: backImageUrl, radius: radius)),
          Positioned(left: radius * 1.6, child: AppAvatar(imageUrl: frontImageUrl, radius: radius)),
        ],
      ),
    );
  }
}
