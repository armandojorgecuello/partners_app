import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:partners_app/core/locale/app_locale.dart';
import 'package:partners_app/design_system/molecules/image_source_dialog.dart';
import 'package:partners_app/features/profile/domain/entities/user_profile.dart';
import 'package:partners_app/features/profile/domain/usecases/upload_profile_image_usecase.dart';
import 'package:partners_app/features/profile/presentation/providers/profile_providers.dart';

/// Avatar + "select photo" tap target, used inside ProfilePage. Relocated
/// from lib/src/pages/others/profile_picture.dart.
class ProfilePictureWidget extends ConsumerWidget {
  final UserProfile profile;

  const ProfilePictureWidget({super.key, required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context);
    final photoUrl = profile.photoUrl ?? '';
    return GestureDetector(
      onTap: () => _select(context, ref),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 8.0),
          Container(
            height: 100.0,
            width: 100.0,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(150.0)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(150.0),
              child: FadeInImage(
                placeholder: const AssetImage('assets/loading/loading.gif'),
                image: photoUrl.isEmpty
                    ? const AssetImage('assets/image/no_image.png') as ImageProvider
                    : NetworkImage(photoUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Center(
            child: Text(
              photoUrl.isEmpty
                  ? 'Seleccionar foto'
                  : localizations?.t('profileInputs.pictureProfileText') ?? '',
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _select(BuildContext context, WidgetRef ref) async {
    final source = await showImageSourceDialog(context);
    if (source == null) return;
    final picked = await ImagePicker().pickImage(source: source);
    if (picked == null) return;

    final result = await ref.read(uploadProfileImageUseCaseProvider).call(
      UploadProfileImageParams(uid: profile.uid, image: File(picked.path)),
    );
    if (!context.mounted) return;

    final localizations = AppLocalizations.of(context);
    result.fold(
      (_) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 4),
          content: Text(
            localizations?.t('profileInputs.snakbarPictureUpdate') ?? '',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
      (failure) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(failure.message)),
      ),
    );
  }
}
