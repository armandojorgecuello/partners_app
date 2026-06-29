import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partners_app/core/theme/app_colors.dart';
import 'package:partners_app/design_system/atoms/app_avatar.dart';
import 'package:partners_app/design_system/atoms/reward_image_background.dart';
import 'package:partners_app/design_system/organisms/async_value_view.dart';
import 'package:partners_app/features/profile/presentation/providers/profile_providers.dart';
import 'package:partners_app/features/tasks/domain/entities/task.dart';
import 'package:partners_app/features/tasks/presentation/pages/view_task_page.dart';

/// Relocated from lib/src/pages/task/task_list.dart's `TaskCard`.
class TaskCard extends ConsumerWidget {
  final Task task;
  final String currentUid;

  const TaskCard({super.key, required this.task, required this.currentUid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final partnerUid = task.partnerUid(currentUid);
    final partnerProfile = ref.watch(userProfileProvider(partnerUid));

    return InkWell(
      borderRadius: BorderRadius.circular(20.0),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => ViewTaskPage(task: task)),
      ),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        color: AppColors.pageDark,
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (task.rewardImgUrl.isNotEmpty) RewardImageBackground(rewardUrl: task.rewardImgUrl),
            Positioned(
              left: 8.0,
              top: 8.0,
              right: 8.0,
              child: AsyncValueView(
                value: partnerProfile,
                data: (profile) => Row(
                  children: [
                    AppAvatar(imageUrl: profile.photoUrl, radius: 16.0),
                    const SizedBox(width: 6.0),
                    Expanded(
                      child: Text(
                        profile.name ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white, fontFamily: 'Sans', fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 8.0,
              bottom: 8.0,
              right: 8.0,
              child: Text(
                task.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Sans',
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
