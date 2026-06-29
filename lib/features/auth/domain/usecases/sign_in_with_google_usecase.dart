import 'package:partners_app/core/error/failure.dart';
import 'package:partners_app/core/result/result.dart';
import 'package:partners_app/core/usecase/usecase.dart';
import 'package:partners_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:partners_app/features/auth/domain/usecases/ensure_user_document_usecase.dart';

/// Returns whether the resulting profile is already complete, so the caller
/// knows whether to route to "home" or "complete your profile".
class SignInWithGoogleUseCase extends UseCase<bool, NoParams> {
  final AuthRepository _authRepository;
  final EnsureUserDocumentUseCase _ensureUserDocument;

  SignInWithGoogleUseCase(this._authRepository, this._ensureUserDocument);

  @override
  Future<Result<bool>> call(NoParams params) async {
    try {
      final user = await _authRepository.signInWithGoogle();
      return _ensureUserDocument(EnsureUserDocumentParams(user: user));
    } catch (e) {
      return Result.err(ServerFailure(e.toString()));
    }
  }
}
