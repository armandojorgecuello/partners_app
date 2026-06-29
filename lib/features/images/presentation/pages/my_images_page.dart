import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:partners_app/core/firebase/firebase_providers.dart';
import 'package:partners_app/core/locale/app_locale.dart';
import 'package:partners_app/core/theme/app_colors.dart';
import 'package:partners_app/features/images/domain/usecases/upload_gallery_image_usecase.dart';
import 'package:partners_app/features/images/presentation/providers/images_providers.dart';
import 'package:partners_app/features/images/presentation/widgets/image_grid.dart';

/// Relocated from lib/src/pages/images/my_images_page.dart.
class MyImagesPage extends ConsumerWidget {
  const MyImagesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context);
    final uid = ref.watch(currentUidProvider)!;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.pageDark,
        appBar: AppBar(
          titleSpacing: 10.0,
          title: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
              Text(localizations?.t('images.title') ?? ''),
              Expanded(child: Container()),
              IconButton(
                icon: const Image(image: AssetImage('assets/image/Camera.png'), height: 24.0),
                onPressed: () => _select(context, ref, localizations),
              ),
            ],
          ),
          centerTitle: false,
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.primary,
        ),
        body: ImageGrid(uid: uid),
      ),
    );
  }

  Future<void> _select(BuildContext context, WidgetRef ref, AppLocalizations? localizations) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImageFrom(context, ref, ImageSource.camera, localizations);
                },
                child: Text(localizations?.t('images.cameraText') ?? ''),
              ),
              const SizedBox(height: 5.0),
              const Divider(),
              const SizedBox(height: 5.0),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImageFrom(context, ref, ImageSource.gallery, localizations);
                },
                child: Text(localizations?.t('images.galleryText') ?? ''),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImageFrom(
    BuildContext context,
    WidgetRef ref,
    ImageSource source,
    AppLocalizations? localizations,
  ) async {
    final picked = await ImagePicker().pickImage(source: source);
    if (picked == null || !context.mounted) return;
    final uid = ref.read(currentUidProvider)!;
    await ref.read(uploadGalleryImageUseCaseProvider).call(
      UploadGalleryImageParams(uid: uid, image: File(picked.path)),
    );
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 4),
        content: Text(localizations?.t('images.snackBarText') ?? '', style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
