import 'dart:io';

import 'package:partners_app/core/error/failure.dart';
import 'package:partners_app/core/result/result.dart';
import 'package:partners_app/core/usecase/usecase.dart';
import 'package:partners_app/features/tasks/domain/repositories/task_repository.dart';

class UpdateRewardImageParams {
  final String taskId;
  final File image;

  const UpdateRewardImageParams({required this.taskId, required this.image});
}

class UpdateRewardImageUseCase extends UseCase<void, UpdateRewardImageParams> {
  final TaskRepository _repository;

  UpdateRewardImageUseCase(this._repository);

  @override
  Future<Result<void>> call(UpdateRewardImageParams params) async {
    try {
      await _repository.updateRewardImage(params.taskId, params.image);
      return const Result.ok(null);
    } catch (e) {
      return Result.err(ServerFailure(e.toString()));
    }
  }
}
