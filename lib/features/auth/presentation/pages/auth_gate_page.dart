import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partners_app/core/firebase/firebase_providers.dart';
import 'package:partners_app/core/theme/app_colors.dart';
import 'package:partners_app/features/auth/presentation/pages/login_page.dart';
import 'package:partners_app/features/auth/presentation/pages/new_user_page.dart';
import 'package:partners_app/features/profile/presentation/providers/profile_providers.dart';
import 'package:partners_app/features/tasks/presentation/pages/task_list_page.dart';

/// Relocated from lib/main.dart's `AuthGate` widget — now reads Firebase
/// auth state and the user's profile entirely through Riverpod providers
/// instead of embedding `FirebaseAuth`/`FirebaseFirestore` calls in the
/// widget tree.
class AuthGatePage extends ConsumerWidget {
  const AuthGatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateChangesProvider);

    return authState.when(
      data: (user) {
        if (user == null) return const LoginPage();
        return _ProfileGate(uid: user.uid);
      },
      loading: () => const _LoadingScaffold(),
      error: (error, _) => const _ErrorScaffold(
        message: 'No se pudo verificar tu sesión. Revisa tu conexión e intenta de nuevo.',
      ),
    );
  }
}

class _ProfileGate extends ConsumerWidget {
  final String uid;

  const _ProfileGate({required this.uid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userProfileProvider(uid));
    return profile.when(
      data: (data) => data.isComplete ? const TaskListPage() : const NewUserPage(),
      loading: () => const _LoadingScaffold(),
      error: (error, _) => const _ErrorScaffold(
        message: 'No se pudo cargar tu perfil. Revisa tu conexión e intenta de nuevo.',
      ),
    );
  }
}

class _LoadingScaffold extends StatelessWidget {
  const _LoadingScaffold();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.scaffoldLight,
      body: Center(child: CircularProgressIndicator(color: AppColors.primary)),
    );
  }
}

class _ErrorScaffold extends StatelessWidget {
  final String message;

  const _ErrorScaffold({required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldLight,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(message, textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
