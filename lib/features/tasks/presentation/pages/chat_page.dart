import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:partners_app/core/firebase/firebase_providers.dart';
import 'package:partners_app/core/locale/app_locale.dart';
import 'package:partners_app/core/theme/app_colors.dart';
import 'package:partners_app/design_system/atoms/app_avatar.dart';
import 'package:partners_app/design_system/molecules/chat_bubble.dart';
import 'package:partners_app/design_system/organisms/async_value_view.dart';
import 'package:partners_app/features/profile/presentation/providers/profile_providers.dart';
import 'package:partners_app/features/tasks/domain/entities/task.dart';
import 'package:partners_app/features/tasks/domain/entities/task_status.dart';
import 'package:partners_app/features/tasks/domain/usecases/send_chat_message_usecase.dart';
import 'package:partners_app/features/tasks/domain/usecases/update_reward_image_usecase.dart';
import 'package:partners_app/features/tasks/domain/usecases/update_task_status_usecase.dart';
import 'package:partners_app/features/tasks/presentation/providers/tasks_providers.dart';

/// Relocated from lib/src/pages/task/new_terms_chat.dart's `ChatPage`.
class ChatPage extends ConsumerStatefulWidget {
  final Task task;

  const ChatPage({super.key, required this.task});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final task = widget.task;
    final uid = ref.watch(currentUidProvider)!;
    final localizations = AppLocalizations.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(task.title, overflow: TextOverflow.ellipsis),
          centerTitle: true,
          backgroundColor: AppColors.primary,
        ),
        backgroundColor: const Color(0xff282828),
        body: Column(
          children: [
            _header(localizations),
            if (task.status == TaskStatus.notStarted && uid == task.receiverUid) _acceptRejectRow(uid, localizations),
            Expanded(child: _messagesList(uid)),
            _composer(uid, localizations),
          ],
        ),
      ),
    );
  }

  Widget _avatar(String uid) {
    final profile = ref.watch(userProfileProvider(uid));
    return AsyncValueView(
      value: profile,
      loading: const AppAvatar(radius: 22.0),
      data: (data) => AppAvatar(radius: 22.0, imageUrl: data.photoUrl),
    );
  }

  Widget _header(AppLocalizations? localizations) {
    final task = widget.task;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      child: Row(
        children: [
          _avatar(task.senderUid),
          const SizedBox(width: 6.0),
          _avatar(task.receiverUid),
          const SizedBox(width: 10.0),
          Expanded(
            child: Text(
              localizations?.t('chatPage.${task.status.raw}') ?? task.status.raw,
              style: const TextStyle(color: Colors.white, fontFamily: 'SansLightItalic', fontSize: 12.0),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _acceptRejectRow(String uid, AppLocalizations? localizations) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            onPressed: () => _respondToRequest(uid, TaskStatus.open),
            child: Text(localizations?.t('chatPage.openButtom2') ?? 'Accept', style: const TextStyle(color: Colors.white)),
          ),
          const SizedBox(width: 10.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => _respondToRequest(uid, TaskStatus.rejected),
            child: Text(localizations?.t('chatPage.openButtom3') ?? 'Reject', style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _messagesList(String uid) {
    final messages = ref.watch(chatMessagesProvider(widget.task.uidTask));
    return AsyncValueView(
      value: messages,
      data: (messages) {
        if (messages.isEmpty) return const SizedBox.shrink();
        return ListView.builder(
          reverse: true,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          itemCount: messages.length,
          itemBuilder: (_, index) {
            final message = messages[messages.length - 1 - index];
            return ChatBubble(
              message: message.message,
              dateTime: message.dateTime ?? DateTime.now(),
              isMine: message.senderUid == uid,
            );
          },
        );
      },
    );
  }

  Widget _composer(String uid, AppLocalizations? localizations) {
    final task = widget.task;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          if (uid == task.senderUid)
            IconButton(icon: const Icon(Icons.camera_alt, color: Colors.grey), onPressed: _pickRewardImage),
          Expanded(
            child: TextField(
              controller: _controller,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xff151515),
                hintText: localizations?.t('chatPage.newTermsText') ?? '',
                hintStyle: const TextStyle(color: Colors.grey),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14.0),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0), borderSide: BorderSide.none),
              ),
            ),
          ),
          IconButton(icon: const Icon(Icons.send, color: AppColors.primary), onPressed: () => _send(uid)),
        ],
      ),
    );
  }

  Future<void> _respondToRequest(String uid, TaskStatus status) async {
    final task = widget.task;
    await ref.read(updateTaskStatusUseCaseProvider).call(
      UpdateTaskStatusParams(taskId: task.uidTask, status: status, recipientUid: task.senderUid, actorUid: task.receiverUid),
    );
  }

  Future<void> _send(String uid) async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    final task = widget.task;
    final receiverUid = task.partnerUid(uid);
    _controller.clear();
    await ref.read(sendChatMessageUseCaseProvider).call(
      SendChatMessageParams(taskId: task.uidTask, senderUid: uid, receiverUid: receiverUid, message: text),
    );
  }

  Future<void> _pickRewardImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null || !mounted) return;
    await ref.read(updateRewardImageUseCaseProvider).call(
      UpdateRewardImageParams(taskId: widget.task.uidTask, image: File(picked.path)),
    );
  }
}
