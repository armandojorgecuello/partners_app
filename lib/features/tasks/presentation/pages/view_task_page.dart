import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:partners_app/core/firebase/firebase_providers.dart';
import 'package:partners_app/core/locale/app_locale.dart';
import 'package:partners_app/core/theme/app_colors.dart';
import 'package:partners_app/features/tasks/domain/entities/task.dart';
import 'package:partners_app/features/tasks/domain/entities/task_status.dart';
import 'package:partners_app/features/tasks/presentation/pages/chat_page.dart';
import 'package:partners_app/features/tasks/presentation/pages/pay_your_partner_page.dart';
import 'package:partners_app/features/tasks/presentation/pages/review_page.dart';
import 'package:partners_app/features/tasks/presentation/pages/start_negotiation_page.dart';

/// Relocated from lib/src/pages/task/view_task.dart.
class ViewTaskPage extends ConsumerWidget {
  final Task task;

  const ViewTaskPage({super.key, required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context);
    final deliveryDate = task.deliveryTime != null
        ? DateFormat("MMM d 'at' HH:mm").format(task.deliveryTime!)
        : null;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.pageDark,
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(localizations?.t('viewTask.title') ?? 'Task'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.chat_bubble_outline, color: Colors.white),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => ChatPage(task: task)),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  task.title,
                  style: const TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              if (deliveryDate != null) ...[
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(deliveryDate, style: const TextStyle(color: Colors.grey)),
                ),
              ],
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  localizations?.t('viewTask.rewardDescription') ?? '',
                  style: const TextStyle(color: Colors.white, fontSize: 15.0),
                ),
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(task.rewardDescription, style: const TextStyle(color: Colors.white, fontSize: 15.0)),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Divider(color: Colors.white),
              ),
              if (task.rewardImgUrl.isNotEmpty) ...[
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    localizations?.t('viewTask.rewardImage') ?? '',
                    style: const TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                ),
                const SizedBox(height: 20.0),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: MediaQuery.of(context).size.height * 0.4,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image(fit: BoxFit.cover, image: NetworkImage(task.rewardImgUrl)),
                      ),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 20.0),
              Center(child: _actionButton(context, ref, localizations)),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _actionButton(BuildContext context, WidgetRef ref, AppLocalizations? localizations) {
    final uid = ref.read(currentUidProvider);
    final taskDate = task.deliveryTime != null ? DateFormat("MMM d 'at' HH:mm").format(task.deliveryTime!) : '';

    Widget elevatedButton(String label, Widget Function() pageBuilder) => ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
      onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => pageBuilder())),
      child: Text(label, style: const TextStyle(color: Colors.white)),
    );

    switch (task.status) {
      case TaskStatus.notStarted:
        return elevatedButton(
          localizations?.t('startNegociation.buttomText') ?? 'Start negotiation',
          () => StartNegotiationPage(task: task),
        );
      case TaskStatus.open:
        if (task.senderUid != uid) return const SizedBox.shrink();
        return elevatedButton(
          localizations?.t('payYourPartner.buttomText') ?? 'Pay',
          () => PayYourPartnerPage(task: task),
        );
      case TaskStatus.paidUpfront:
        return elevatedButton(
          localizations?.t('home_page.sendReview') ?? 'Review',
          () => ReviewPage(task: task, taskDate: taskDate),
        );
      case TaskStatus.reviewed:
        return elevatedButton(
          localizations?.t('home_page.checkReview') ?? 'Check review',
          () => ReviewPage(task: task, taskDate: taskDate),
        );
      case TaskStatus.rejected:
        return const SizedBox.shrink();
    }
  }
}
