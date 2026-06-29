import 'dart:io';

import 'package:partners_app/core/error/failure.dart';
import 'package:partners_app/core/result/result.dart';
import 'package:partners_app/core/usecase/usecase.dart';
import 'package:partners_app/features/images/domain/repositories/gallery_repository.dart';

class UploadGalleryImageParams {
  final String uid;
  final File image;

  const UploadGalleryImageParams({required this.uid, required this.image});
}

class UploadGalleryImageUseCase extends UseCase<void, UploadGalleryImageParams> {
  final GalleryRepository _repository;

  UploadGalleryImageUseCase(this._repository);

  @override
  Future<Result<void>> call(UploadGalleryImageParams params) async {
    try {
      await _repository.uploadImage(params.uid, params.image);
      return const Result.ok(null);
    } catch (e) {
      return Result.err(ServerFailure(e.toString()));
    }
  }
}
