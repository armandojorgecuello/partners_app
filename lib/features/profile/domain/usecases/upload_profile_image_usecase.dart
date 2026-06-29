import 'dart:io';

import 'package:partners_app/core/error/failure.dart';
import 'package:partners_app/core/result/result.dart';
import 'package:partners_app/core/usecase/usecase.dart';
import 'package:partners_app/features/profile/domain/repositories/profile_repository.dart';

class UploadProfileImageParams {
  final String uid;
  final File image;

  const UploadProfileImageParams({required this.uid, required this.image});
}

class UploadProfileImageUseCase extends UseCase<String, UploadProfileImageParams> {
  final ProfileRepository _repository;

  UploadProfileImageUseCase(this._repository);

  @override
  Future<Result<String>> call(UploadProfileImageParams params) async {
    try {
      final url = await _repository.uploadProfileImage(params.uid, params.image);
      return Result.ok(url);
    } catch (e) {
      return Result.err(ServerFailure(e.toString()));
    }
  }
}
