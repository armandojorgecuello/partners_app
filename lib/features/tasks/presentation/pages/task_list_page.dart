import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partners_app/core/firebase/firebase_providers.dart';
import 'package:partners_app/core/locale/app_locale.dart';
import 'package:partners_app/core/router/app_routes.dart';
import 'package:partners_app/core/theme/app_colors.dart';
import 'package:partners_app/design_system/organisms/async_value_view.dart';
import 'package:partners_app/features/tasks/presentation/providers/tasks_providers.dart';
import 'package:partners_app/features/tasks/presentation/widgets/task_card.dart';

/// Relocated from lib/src/pages/task/task_list.dart's `TasksPage`.
class TaskListPage extends ConsumerWidget {
  const TaskListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context);
    final uid = ref.watch(currentUidProvider)!;

    return Scaffold(
      backgroundColor: const Color(0xff282828),
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(localizations?.t('loginPage.appName') ?? 'Partners'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () => Navigator.of(context).pushNamed(AppRoutes.notifications),
          ),
          IconButton(
            icon: const Icon(Icons.people),
            onPressed: () => Navigator.of(context).pushNamed(AppRoutes.partnersAccepted),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.of(context).pushNamed(AppRoutes.settings),
          ),
        ],
      ),
      body: AsyncValueView(
        value: ref.watch(tasksProvider(uid)),
        errorMessage: (_) => localizations?.t('home_page.noTasks') ?? 'No se pudieron cargar las tareas.',
        data: (tasks) {
          if (tasks.isEmpty) {
            return Center(
              child: Text(
                localizations?.t('home_page.noTasks') ?? 'No tasks yet',
                style: const TextStyle(color: Colors.white),
              ),
            );
          }
          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 0.85,
            ),
            itemCount: tasks.length,
            itemBuilder: (context, index) => TaskCard(task: tasks[index], currentUid: uid),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () => Navigator.of(context).pushNamed(AppRoutes.newTask),
        child: const Icon(Icons.add),
      ),
    );
  }
}
