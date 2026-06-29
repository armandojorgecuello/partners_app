import 'package:flutter/material.dart';
import 'package:partners_app/core/theme/app_colors.dart';

/// Shared shell for the auth/onboarding journey: gradient background +
/// fade-in content, replacing the duplicated `AnimationController` +
/// gradient `Container` boilerplate in get_phone.dart, verify.dart and
/// new_user.dart.
class AuthScaffoldTemplate extends StatefulWidget {
  final Widget child;

  const AuthScaffoldTemplate({super.key, required this.child});

  @override
  State<AuthScaffoldTemplate> createState() => _AuthScaffoldTemplateState();
}

class _AuthScaffoldTemplateState extends State<AuthScaffoldTemplate>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.primary, AppColors.primaryDark],
          ),
        ),
        child: SafeArea(child: FadeTransition(opacity: _fade, child: widget.child)),
      ),
    );
  }
}
