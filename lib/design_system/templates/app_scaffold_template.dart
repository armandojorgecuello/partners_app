import 'package:flutter/material.dart';
import 'package:partners_app/core/theme/app_colors.dart';
import 'package:partners_app/design_system/organisms/custom_app_bar.dart';

/// Shared shell for authenticated pages: [CustomAppBar] + dark surface +
/// padded body, replacing the Scaffold boilerplate repeated across
/// task/profile/settings pages.
class AppScaffoldTemplate extends StatelessWidget {
  final String title;
  final String backLabel;
  final Widget body;
  final Widget? floatingActionButton;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;

  const AppScaffoldTemplate({
    super.key,
    required this.title,
    required this.backLabel,
    required this.body,
    this.floatingActionButton,
    this.padding = const EdgeInsets.all(16),
    this.backgroundColor = AppColors.pageDark,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(title: title, backLabel: backLabel),
      floatingActionButton: floatingActionButton,
      body: Padding(padding: padding, child: body),
    );
  }
}
