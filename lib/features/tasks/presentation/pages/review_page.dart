import 'package:demoji/demoji.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partners_app/core/firebase/firebase_providers.dart';
import 'package:partners_app/core/locale/app_locale.dart';
import 'package:partners_app/core/theme/app_colors.dart';
import 'package:partners_app/design_system/atoms/app_avatar.dart';
import 'package:partners_app/design_system/organisms/async_value_view.dart';
import 'package:partners_app/features/profile/presentation/providers/profile_providers.dart';
import 'package:partners_app/features/tasks/domain/entities/task.dart';
import 'package:partners_app/features/tasks/domain/entities/task_status.dart';
import 'package:partners_app/features/tasks/domain/usecases/submit_review_usecase.dart';
import 'package:partners_app/features/tasks/presentation/providers/tasks_providers.dart';

/// Relocated from lib/src/pages/others/review_widget.dart's `Review` widget.
/// Reads reviewValue/reviewDescription/status straight off [task] instead of
/// the original's redundant separate constructor params for the same data.
class ReviewPage extends ConsumerStatefulWidget {
  final Task task;
  final String taskDate;

  const ReviewPage({super.key, required this.task, required this.taskDate});

  @override
  ConsumerState<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends ConsumerState<ReviewPage> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  String _reviewDescription = '';

  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
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
    final localizations = AppLocalizations.of(context);
    final task = widget.task;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: SizedBox(
                height: 40.0,
                width: 100.0,
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.arrow_back_ios, color: Colors.white),
                    Text(
                      localizations?.t('support.back') ?? '',
                      style: const TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 15.0),
            Text(
              task.status == TaskStatus.reviewed
                  ? localizations?.t('home_page.checkReview') ?? ''
                  : localizations?.t('home_page.sendReview') ?? '',
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      backgroundColor: AppColors.pageDark,
      body: Stack(children: [_body(localizations)]),
    );
  }

  Widget _body(AppLocalizations? localizations) {
    final task = widget.task;
    final uid = ref.watch(currentUidProvider);
    if (task.status == TaskStatus.reviewed) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.2,
                  child: _avatar(uid == task.senderUid ? task.senderUid : task.receiverUid),
                ),
                Positioned(
                  right: MediaQuery.of(context).size.width * 0.2,
                  child: _avatar(uid == task.senderUid ? task.receiverUid : task.senderUid),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.calendar_today, color: Colors.white, size: 14),
              const SizedBox(width: 10.0),
              Text(widget.taskDate, style: const TextStyle(color: Colors.white, fontFamily: 'SansRegularlight', fontSize: 14.0)),
            ],
          ),
          const SizedBox(height: 10.0),
          Text(task.title, style: const TextStyle(color: Colors.white, fontFamily: 'Sans', fontSize: 16.0)),
          const SizedBox(height: 10.0),
          task.reviewValue != 'like'
              ? Text(Demoji.slightly_frowning_face, style: const TextStyle(fontSize: 60.0, color: Colors.yellow))
              : Text(Demoji.grin, style: const TextStyle(fontSize: 80.0, color: Colors.yellow)),
          const SizedBox(height: 10.0),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  localizations?.t('home_page.reviewDescription') ?? '',
                  style: const TextStyle(color: Colors.white, fontFamily: 'Sans', fontSize: 18.0),
                ),
                const SizedBox(height: 10.0),
                Text(
                  task.reviewDescription.isNotEmpty
                      ? task.reviewDescription
                      : localizations?.t('home_page.commentsEmpty') ?? '',
                  style: const TextStyle(color: Colors.white, fontFamily: 'SansRegularlight', fontSize: 18.0),
                ),
              ],
            ),
          ),
        ],
      );
    }
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Positioned(
                    left: MediaQuery.of(context).size.width * 0.2,
                    child: _avatar(uid == task.senderUid ? task.senderUid : task.receiverUid),
                  ),
                  Positioned(
                    right: MediaQuery.of(context).size.width * 0.2,
                    child: _avatar(uid == task.senderUid ? task.receiverUid : task.senderUid),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.calendar_today, color: Colors.white, size: 12),
                  const SizedBox(width: 10.0),
                  Text(widget.taskDate, style: const TextStyle(color: Colors.white, fontFamily: 'SansRegularlight', fontSize: 14.0)),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(task.title, style: const TextStyle(color: Colors.white, fontFamily: 'Sans', fontSize: 18.0)),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                localizations?.t('home_page.textDialogTaskCompleted') ?? '',
                style: const TextStyle(color: Colors.white, fontFamily: 'Sans', fontSize: 14.0),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                maxLines: 3,
                validator: (value) => (value == null || value.isEmpty) ? 'Review is empty' : null,
                style: const TextStyle(color: Colors.white),
                onChanged: (value) => setState(() => _reviewDescription = value),
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                localizations?.t('home_page.askEndTaskreview') ?? '',
                style: const TextStyle(color: Colors.white, fontFamily: 'Sans', fontSize: 14.0),
              ),
            ),
            const SizedBox(height: 20.0),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 33.0,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(50.0), color: AppColors.primary),
                    child: ElevatedButton(
                      onPressed: () => _submit('like'),
                      child: Row(
                        children: [
                          Text(
                            localizations?.t('home_page.buttonTaskCompletedDialogYes') ?? '',
                            style: const TextStyle(color: Colors.white, fontFamily: 'SansRegularlight', fontSize: 14.0),
                          ),
                          const SizedBox(width: 10.0),
                          Text(Demoji.grin),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Container(
                    height: 33.0,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(50.0), color: AppColors.primary),
                    child: ElevatedButton(
                      onPressed: () => _submit('unlike'),
                      child: Row(
                        children: [
                          Text(
                            localizations?.t('home_page.buttonTaskCompletedDialogNo') ?? '',
                            style: const TextStyle(color: Colors.white, fontFamily: 'SansRegularlight', fontSize: 14.0),
                          ),
                          const SizedBox(width: 10.0),
                          Text(Demoji.slightly_frowning_face),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }

  Future<void> _submit(String reviewValue) async {
    if (!_formKey.currentState!.validate()) return;
    final task = widget.task;
    final actorUid = ref.read(currentUidProvider)!;
    final otherUid = task.partnerUid(actorUid);
    await ref.read(submitReviewUseCaseProvider).call(
      SubmitReviewParams(
        taskId: task.uidTask,
        reviewValue: reviewValue,
        reviewDescription: _reviewDescription,
        recipientUid: otherUid,
        actorUid: actorUid,
      ),
    );
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  Widget _avatar(String uid) {
    return FadeTransition(
      opacity: _animation,
      child: AsyncValueView(
        value: ref.watch(userProfileProvider(uid)),
        data: (profile) => AppAvatar(radius: 70.0, imageUrl: profile.photoUrl),
      ),
    );
  }
}
