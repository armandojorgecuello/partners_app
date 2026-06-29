import 'package:flutter/material.dart';

/// Relocated from lib/src/widget/background_image.dart, same behavior.
class RewardImageBackground extends StatelessWidget {
  final String rewardUrl;

  const RewardImageBackground({super.key, required this.rewardUrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Container(
        color: const Color(0xFFE6F4F1),
        child: Image(
          image: NetworkImage(rewardUrl),
          fit: BoxFit.cover,
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            if (wasSynchronouslyLoaded) return child;
            return AnimatedOpacity(
              opacity: frame == null ? 0 : 1,
              duration: const Duration(milliseconds: 300),
              child: child,
            );
          },
        ),
      ),
    );
  }
}
