import 'package:flutter/material.dart';
import 'package:partners_app/design_system/atoms/app_button.dart';

/// Generic confirm/cancel dialog, replacing the bespoke `AlertDialog`s in
/// partner_accept_list.dart and partners_requests_list.dart.
Future<bool> showConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  String confirmLabel = 'OK',
  String cancelLabel = 'Cancel',
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: const Color(0xff282828),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      content: Text(message, style: const TextStyle(color: Colors.white70)),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(cancelLabel, style: const TextStyle(color: Colors.white70)),
        ),
        AppButton(label: confirmLabel, onPressed: () => Navigator.of(context).pop(true)),
      ],
    ),
  );
  return result ?? false;
}

/// Single-button informational dialog, replacing `_showDialog` in
/// partner_request_validation.dart.
Future<void> showInfoDialog(BuildContext context, {required String title, required String message}) {
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: const Color(0xff282828),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'SansRegular',
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontFamily: 'SansRegularlight', fontSize: 14),
          ),
          const SizedBox(height: 20),
          AppButton(label: 'OK', onPressed: () => Navigator.of(context).pop()),
        ],
      ),
    ),
  );
}
