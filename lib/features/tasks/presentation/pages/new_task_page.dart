import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:partners_app/core/firebase/firebase_providers.dart';
import 'package:partners_app/core/locale/app_locale.dart';
import 'package:partners_app/core/router/app_routes.dart';
import 'package:partners_app/core/theme/app_colors.dart';
import 'package:partners_app/design_system/atoms/app_avatar.dart';
import 'package:partners_app/design_system/molecules/image_source_dialog.dart';
import 'package:partners_app/design_system/organisms/async_value_view.dart';
import 'package:partners_app/features/profile/presentation/providers/profile_providers.dart';
import 'package:partners_app/features/tasks/domain/usecases/create_task_usecase.dart';
import 'package:partners_app/features/tasks/presentation/providers/tasks_providers.dart';

/// Relocated from lib/src/pages/task/new_task_page.dart. The partner to
/// create a task for is now a typed route argument instead of the original
/// `SinglePartner.uid`/`uidPartner` static singleton.
class NewTaskPage extends ConsumerStatefulWidget {
  final String? partnerUid;

  const NewTaskPage({super.key, this.partnerUid});

  @override
  ConsumerState<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends ConsumerState<NewTaskPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _inputDateTime = TextEditingController();
  String? _title;
  String? _reward;
  DateTime? _deliveryDateTime;
  File? _image;
  bool _loading = false;

  @override
  void dispose() {
    _inputDateTime.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final partnerUid = widget.partnerUid;
    final user = ref.watch(currentUidProvider)!;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(localizations?.t('newTask.titleTask') ?? ''),
          centerTitle: true,
          backgroundColor: AppColors.primary,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        backgroundColor: const Color(0xff282828),
        body: partnerUid == null
            ? Center(
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pushNamed(AppRoutes.partnersAccepted),
                  child: Text(localizations?.t('newTask.taptoSelectPartmer') ?? ''),
                ),
              )
            : _form(context, localizations, user, partnerUid),
      ),
    );
  }

  Widget _form(BuildContext context, AppLocalizations? localizations, String user, String partnerUid) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                localizations?.t('newTask.partner') ?? '',
                style: const TextStyle(color: Colors.white, fontFamily: 'Sans', fontSize: 14.0),
              ),
            ),
            AsyncValueView(
              value: ref.watch(userProfileProvider(partnerUid)),
              data: (profile) => ListTile(
                leading: AppAvatar(radius: 30.0, imageUrl: profile.photoUrl),
                title: Text(
                  profile.name ?? '',
                  style: const TextStyle(color: Colors.white, fontFamily: 'SansRegular', fontSize: 14.0),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Divider(color: Colors.white),
            ),
            const SizedBox(height: 10.0),
            _label(localizations?.t('newTask.taskName') ?? ''),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                validator: (value) => (value == null || value.isEmpty) ? 'Required' : null,
                decoration: _inputDecoration(localizations?.t('newTask.taskHint') ?? ''),
                onChanged: (value) => _title = value,
                cursorColor: Colors.grey,
                textCapitalization: TextCapitalization.words,
                style: const TextStyle(color: Colors.grey, fontFamily: 'SansRegularlight', fontSize: 14.0),
              ),
            ),
            const SizedBox(height: 20.0),
            _label(localizations?.t('newTask.timeLimit') ?? ''),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                controller: _inputDateTime,
                readOnly: true,
                decoration: _inputDecoration(localizations?.t('newTask.hintTimeLimit') ?? ''),
                onTap: () => _selectDate(context),
                style: const TextStyle(color: Colors.grey, fontFamily: 'SansRegularlight', fontSize: 14.0),
              ),
            ),
            const SizedBox(height: 10.0),
            _label(localizations?.t('newTask.rewardTitle') ?? ''),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                validator: (value) => (value == null || value.isEmpty) ? 'Required' : null,
                decoration: _inputDecoration(localizations?.t('newTask.hintReward') ?? ''),
                onChanged: (value) => _reward = value,
                cursorColor: Colors.grey,
                textCapitalization: TextCapitalization.words,
                style: const TextStyle(color: Colors.grey, fontFamily: 'SansRegularlight', fontSize: 14.0),
              ),
            ),
            const SizedBox(height: 10.0),
            _label(localizations?.t('newTask.rewardImage') ?? ''),
            const SizedBox(height: 5.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: GestureDetector(onTap: _selectImage, child: _showImage()),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                      onPressed: () => _sendTask(context, user, partnerUid),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Text(
                            localizations?.t('newTask.buttomTaskText') ?? '',
                            style: const TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 14.0, fontFamily: 'Sans')),
  );

  InputDecoration _inputDecoration(String hint) => InputDecoration(
    enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
    hintText: hint,
    hintStyle: const TextStyle(color: Colors.grey, fontFamily: 'SansRegularlight', fontSize: 14.0),
  );

  Widget _showImage() {
    if (_image == null) {
      return Container(
        height: 150.0,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: Colors.grey[800]),
        child: const Center(child: Icon(Icons.add_a_photo, color: Colors.white)),
      );
    }
    return SizedBox(
      height: 150.0,
      width: double.infinity,
      child: ClipRRect(borderRadius: BorderRadius.circular(20.0), child: Image.file(_image!, fit: BoxFit.cover)),
    );
  }

  Future<void> _selectImage() async {
    final source = await showImageSourceDialog(context);
    if (source == null) return;
    final picked = await ImagePicker().pickImage(source: source);
    if (picked == null) return;
    setState(() => _image = File(picked.path));
  }

  Future<void> _selectDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (date == null) return;
    if (!context.mounted) return;
    final time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (time == null) return;
    _deliveryDateTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    _inputDateTime.text = DateFormat("MMM d 'at' HH:mm").format(_deliveryDateTime!);
  }

  Future<void> _sendTask(BuildContext context, String user, String partnerUid) async {
    if (!_formKey.currentState!.validate() || _image == null) return;
    setState(() => _loading = true);
    await ref.read(createTaskUseCaseProvider).call(
      CreateTaskParams(
        image: _image!,
        title: _title!,
        senderUid: user,
        receiverUid: partnerUid,
        deliveryTime: _deliveryDateTime ?? DateTime.now().add(const Duration(days: 7)),
        reward: _reward!,
      ),
    );
    if (!context.mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);
  }
}
