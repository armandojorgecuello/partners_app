import 'package:flutter/material.dart';
import 'package:partners_app/core/theme/app_colors.dart';

/// Emoji + text, replacing the inline sentiment mapping in review_widget.dart.
class ReviewSentimentLabel extends StatelessWidget {
  final String reviewValue;

  const ReviewSentimentLabel({super.key, required this.reviewValue});

  @override
  Widget build(BuildContext context) {
    final isPositive = reviewValue == 'like';
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(isPositive ? '😀' : '🙁', style: const TextStyle(fontSize: 20)),
        const SizedBox(width: 8),
        Text(
          isPositive ? 'Liked' : 'Disliked',
          style: const TextStyle(color: AppColors.white),
        ),
      ],
    );
  }
}
