import 'package:firebase_auth/firebase_auth.dart';
import 'package:partners_app/core/error/failure.dart';
import 'package:partners_app/core/result/result.dart';
import 'package:partners_app/core/usecase/usecase.dart';
import 'package:partners_app/features/profile/domain/repositories/profile_repository.dart';

class EnsureUserDocumentParams {
  final User user;

  const EnsureUserDocumentParams({required this.user});
}

/// Creates the `users/{uid}` document on first sign-in (Google or phone) and
/// reports whether the profile was already complete — the same decision
/// `lib/main.dart`'s `AuthGate` and the phone/Google sign-in flows used to
/// make inline against raw Firestore reads.
///
/// Depends on features/profile's domain repository (one-directional:
/// auth -> profile), never the reverse.
class EnsureUserDocumentUseCase extends UseCase<bool, EnsureUserDocumentParams> {
  final ProfileRepository _profileRepository;

  EnsureUserDocumentUseCase(this._profileRepository);

  @override
  Future<Result<bool>> call(EnsureUserDocumentParams params) async {
    try {
      final exists = await _profileRepository.profileExists(params.user.uid);
      if (!exists) {
        await _profileRepository.createProfile(
          uid: params.user.uid,
          allowPush: true,
          name: params.user.displayName,
          email: params.user.email,
          preferences: '',
          celNumber: '',
          photoUrl: params.user.photoURL,
          partnerCheck: true,
          acceptTerms: true,
        );
        return const Result.ok(false);
      }
      final profile = await _profileRepository.getProfile(params.user.uid);
      return Result.ok(profile.isComplete);
    } catch (e) {
      return Result.err(ServerFailure(e.toString()));
    }
  }
}
