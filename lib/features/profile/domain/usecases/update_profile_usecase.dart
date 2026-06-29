import 'package:partners_app/core/error/failure.dart';
import 'package:partners_app/core/result/result.dart';
import 'package:partners_app/core/usecase/usecase.dart';
import 'package:partners_app/features/profile/domain/repositories/profile_repository.dart';

class UpdateProfileParams {
  final String uid;
  final String? name;
  final String? email;
  final String? preferences;
  final String? celNumber;

  const UpdateProfileParams({
    required this.uid,
    this.name,
    this.email,
    this.preferences,
    this.celNumber,
  });
}

/// Saves the profile-completion/edit form. Mirrors the original behavior of
/// always clearing `first_launch` on save (cheap no-op once already false).
class UpdateProfileUseCase extends UseCase<void, UpdateProfileParams> {
  final ProfileRepository _repository;

  UpdateProfileUseCase(this._repository);

  @override
  Future<Result<void>> call(UpdateProfileParams params) async {
    try {
      await _repository.updateProfile(
        uid: params.uid,
        name: params.name,
        email: params.email,
        preferences: params.preferences,
        celNumber: params.celNumber,
      );
      return const Result.ok(null);
    } catch (e) {
      return Result.err(ServerFailure(e.toString()));
    }
  }
}
