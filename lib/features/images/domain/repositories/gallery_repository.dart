import 'dart:io';

import 'package:partners_app/features/images/domain/entities/gallery_image.dart';

abstract class GalleryRepository {
  Stream<List<GalleryImage>> watchImages(String uid);

  Future<void> uploadImage(String uid, File image);
}
