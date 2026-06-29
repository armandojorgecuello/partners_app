import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partners_app/core/firebase/firebase_providers.dart';
import 'package:partners_app/core/locale/app_locale.dart';
import 'package:partners_app/core/theme/app_colors.dart';
import 'package:partners_app/design_system/molecules/dual_avatar_stack.dart';
import 'package:partners_app/features/profile/presentation/providers/profile_providers.dart';
import 'package:partners_app/features/tasks/domain/entities/task.dart';
import 'package:partners_app/features/tasks/domain/entities/task_status.dart';
import 'package:partners_app/features/tasks/domain/usecases/update_task_status_usecase.dart';
import 'package:partners_app/features/tasks/presentation/providers/tasks_providers.dart';

/// Relocated from lib/src/pages/task/start_negociation_task.dart.
class StartNegotiationPage extends ConsumerStatefulWidget {
  final Task task;

  const StartNegotiationPage({super.key, required this.task});

  @override
  ConsumerState<StartNegotiationPage> createState() => _StartNegotiationPageState();
}

class _StartNegotiationPageState extends ConsumerState<StartNegotiationPage> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final task = widget.task;
    final localizations = AppLocalizations.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(localizations),
        backgroundColor: AppColors.pageDark,
        body: Stack(
          children: [
            Opacity(
              opacity: 0.1,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: task.rewardImgUrl.isNotEmpty
                    ? FadeInImage(
                        placeholder: const AssetImage('assets/loading/loading.gif'),
                        image: NetworkImage(task.rewardImgUrl),
                        fit: BoxFit.cover,
                      )
                    : const Center(child: Icon(Icons.image, color: Colors.white, size: 48.0)),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.85,
              child: ListView(
                children: <Widget>[
                  Stack(
                    children: [
                      Positioned(child: FadeTransition(opacity: _animation, child: _leadingTask())),
                      Positioned(
                        top: 90.0,
                        left: 10.0,
                        right: 10.0,
                        child: FadeTransition(opacity: _animation, child: _titleTask(localizations)),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 130.0, left: 10.0, right: 10.0),
                        child: Divider(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 10.0,
              left: 10.0,
              right: 10.0,
              child: FadeTransition(opacity: _animation, child: _button(localizations)),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar(AppLocalizations? localizations) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(Icons.arrow_back_ios, color: Colors.white),
            Text(
              localizations?.t('startNegociation.back') ?? '',
              style: const TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      centerTitle: true,
      backgroundColor: AppColors.primary,
    );
  }

  Widget _leadingTask() {
    final task = widget.task;
    final sender = ref.watch(userProfileProvider(task.senderUid));
    final receiver = ref.watch(userProfileProvider(task.receiverUid));
    return SizedBox(
      height: 80.0,
      width: MediaQuery.of(context).size.width,
      child: DualAvatarStack(backImageUrl: sender.value?.photoUrl, frontImageUrl: receiver.value?.photoUrl, radius: 30.0),
    );
  }

  Widget _titleTask(AppLocalizations? localizations) {
    final task = widget.task;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.title,
            style: const TextStyle(color: Colors.white, fontSize: 14.0, fontFamily: 'Sans'),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4.0),
          Text(
            task.status == TaskStatus.notStarted
                ? localizations?.t('startNegociation.notStarted') ?? ''
                : task.status.raw,
            style: const TextStyle(color: Colors.white, fontSize: 12.0, fontFamily: 'SansLightItalic', fontStyle: FontStyle.italic),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _button(AppLocalizations? localizations) {
    final task = widget.task;
    if (task.status != TaskStatus.notStarted) return const SizedBox.shrink();
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(70.0)),
        ),
        onPressed: () async {
          final actorUid = ref.read(currentUidProvider)!;
          final otherUid = task.partnerUid(actorUid);
          await ref.read(updateTaskStatusUseCaseProvider).call(
            UpdateTaskStatusParams(taskId: task.uidTask, status: TaskStatus.open, recipientUid: otherUid, actorUid: actorUid),
          );
          if (!mounted) return;
          Navigator.of(context).pop();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            localizations?.t('startNegociation.buttomText') ?? '',
            style: const TextStyle(color: Colors.white, fontSize: 14.0, fontFamily: 'SansRegularlight'),
          ),
        ),
      ),
    );
  }
}
