import 'package:partners_app/core/error/failure.dart';
import 'package:partners_app/core/result/result.dart';
import 'package:partners_app/core/usecase/usecase.dart';
import 'package:partners_app/features/profile/domain/repositories/profile_repository.dart';

class UpdateCelNumberParams {
  final String uid;
  final String celNumber;

  const UpdateCelNumberParams({required this.uid, required this.celNumber});
}

class UpdateCelNumberUseCase extends UseCase<void, UpdateCelNumberParams> {
  final ProfileRepository _repository;

  UpdateCelNumberUseCase(this._repository);

  @override
  Future<Result<void>> call(UpdateCelNumberParams params) async {
    try {
      await _repository.updateCelNumber(params.uid, params.celNumber);
      return const Result.ok(null);
    } catch (e) {
      return Result.err(ServerFailure(e.toString()));
    }
  }
}
