import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:partners_app/core/theme/app_colors.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final DateTime dateTime;
  final bool isMine;

  const ChatBubble({super.key, required this.message, required this.dateTime, required this.isMine});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isMine ? AppColors.primary : AppColors.cardDark,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, style: const TextStyle(color: AppColors.white)),
            const SizedBox(height: 2),
            Text(
              DateFormat('HH:mm').format(dateTime),
              style: const TextStyle(color: AppColors.white70, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}
