import 'dart:io';

import 'package:partners_app/features/images/data/datasources/gallery_remote_data_source.dart';
import 'package:partners_app/features/images/data/datasources/gallery_storage_data_source.dart';
import 'package:partners_app/features/images/domain/entities/gallery_image.dart';
import 'package:partners_app/features/images/domain/repositories/gallery_repository.dart';

class GalleryRepositoryImpl implements GalleryRepository {
  final GalleryRemoteDataSource _remote;
  final GalleryStorageDataSource _storage;

  GalleryRepositoryImpl(this._remote, this._storage);

  @override
  Stream<List<GalleryImage>> watchImages(String uid) {
    return _remote.watchImages(uid).map((models) => models.map((m) => m.toEntity()).toList());
  }

  @override
  Future<void> uploadImage(String uid, File image) async {
    final url = await _storage.uploadImage(uid, image);
    await _remote.addImage(uid, url);
  }
}
