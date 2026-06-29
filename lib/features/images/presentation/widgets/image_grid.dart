import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partners_app/core/locale/app_locale.dart';
import 'package:partners_app/design_system/organisms/async_value_view.dart';
import 'package:partners_app/features/images/presentation/providers/images_providers.dart';

/// Relocated from lib/src/pages/images/grid_images.dart's `ImageGridItem`.
class ImageGrid extends ConsumerWidget {
  final String uid;

  const ImageGrid({super.key, required this.uid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context);
    return AsyncValueView(
      value: ref.watch(galleryImagesProvider(uid)),
      data: (images) {
        if (images.isEmpty) {
          return Center(
            child: Text(localizations?.t('images.text_1') ?? '', style: const TextStyle(color: Colors.white)),
          );
        }
        return GridView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: images.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          ),
          itemBuilder: (context, index) => ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: CachedNetworkImage(
              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
              imageUrl: images[index].photoUrl,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
