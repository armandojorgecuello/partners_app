import 'package:partners_app/core/error/failure.dart';
import 'package:partners_app/core/result/result.dart';
import 'package:partners_app/core/usecase/usecase.dart';
import 'package:partners_app/features/profile/domain/repositories/profile_repository.dart';

/// Looks up a user by their shareable `usercode` (used by features/partners'
/// "add by code" flow).
class FindPartnerByCodeUseCase extends UseCase<String, String> {
  final ProfileRepository _repository;

  FindPartnerByCodeUseCase(this._repository);

  @override
  Future<Result<String>> call(String code) async {
    try {
      final uid = await _repository.findUidByUserCode(code.trim().toUpperCase());
      if (uid == null) {
        return const Result.err(ValidationFailure('Code not found'));
      }
      return Result.ok(uid);
    } catch (e) {
      return Result.err(ServerFailure(e.toString()));
    }
  }
}
