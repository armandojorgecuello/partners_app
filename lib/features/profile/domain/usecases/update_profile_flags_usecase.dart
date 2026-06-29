import 'package:partners_app/core/error/failure.dart';
import 'package:partners_app/core/result/result.dart';
import 'package:partners_app/core/usecase/usecase.dart';
import 'package:partners_app/features/profile/domain/repositories/profile_repository.dart';

class UpdateProfileFlagsParams {
  final String uid;
  final bool? allowPush;
  final bool? allowEmail;
  final bool? partnerCheck;
  final bool? acceptTerms;

  const UpdateProfileFlagsParams({
    required this.uid,
    this.allowPush,
    this.allowEmail,
    this.partnerCheck,
    this.acceptTerms,
  });
}

/// Covers the four independent boolean toggles previously spread across
/// `updateNotificationActivate`, `updateAllowEmails`, `updatepartnerCheck`
/// and `updatacceptTerms` in the old `UsuarioProvider`.
class UpdateProfileFlagsUseCase extends UseCase<void, UpdateProfileFlagsParams> {
  final ProfileRepository _repository;

  UpdateProfileFlagsUseCase(this._repository);

  @override
  Future<Result<void>> call(UpdateProfileFlagsParams params) async {
    try {
      await _repository.updateProfileFlags(
        uid: params.uid,
        allowPush: params.allowPush,
        allowEmail: params.allowEmail,
        partnerCheck: params.partnerCheck,
        acceptTerms: params.acceptTerms,
      );
      return const Result.ok(null);
    } catch (e) {
      return Result.err(ServerFailure(e.toString()));
    }
  }
}
