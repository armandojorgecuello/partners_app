import 'package:partners_app/core/error/failure.dart';
import 'package:partners_app/core/result/result.dart';
import 'package:partners_app/core/usecase/usecase.dart';
import 'package:partners_app/features/profile/domain/repositories/profile_repository.dart';

class CreateProfileParams {
  final String uid;
  final bool allowPush;
  final String? name;
  final String? email;
  final String? preferences;
  final String? celNumber;
  final String? photoUrl;
  final bool partnerCheck;
  final bool acceptTerms;

  const CreateProfileParams({
    required this.uid,
    required this.allowPush,
    this.name,
    this.email,
    this.preferences,
    this.celNumber,
    this.photoUrl,
    required this.partnerCheck,
    required this.acceptTerms,
  });
}

class CreateProfileUseCase extends UseCase<void, CreateProfileParams> {
  final ProfileRepository _repository;

  CreateProfileUseCase(this._repository);

  @override
  Future<Result<void>> call(CreateProfileParams params) async {
    try {
      await _repository.createProfile(
        uid: params.uid,
        allowPush: params.allowPush,
        name: params.name,
        email: params.email,
        preferences: params.preferences,
        celNumber: params.celNumber,
        photoUrl: params.photoUrl,
        partnerCheck: params.partnerCheck,
        acceptTerms: params.acceptTerms,
      );
      return const Result.ok(null);
    } catch (e) {
      return Result.err(ServerFailure(e.toString()));
    }
  }
}
