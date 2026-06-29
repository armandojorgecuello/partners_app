import 'package:firebase_auth/firebase_auth.dart';
import 'package:partners_app/core/error/failure.dart';
import 'package:partners_app/core/result/result.dart';
import 'package:partners_app/core/usecase/usecase.dart';
import 'package:partners_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:partners_app/features/auth/domain/usecases/ensure_user_document_usecase.dart';

class SignInWithEmailParams {
  final String email;
  final String password;

  const SignInWithEmailParams({required this.email, required this.password});
}

/// Returns whether the resulting profile is already complete, so the caller
/// knows whether to route to "home" or "complete your profile".
class SignInWithEmailUseCase extends UseCase<bool, SignInWithEmailParams> {
  final AuthRepository _authRepository;
  final EnsureUserDocumentUseCase _ensureUserDocument;

  SignInWithEmailUseCase(this._authRepository, this._ensureUserDocument);

  @override
  Future<Result<bool>> call(SignInWithEmailParams params) async {
    try {
      final user = await _authRepository.signInWithEmail(email: params.email, password: params.password);
      return _ensureUserDocument(EnsureUserDocumentParams(user: user));
    } on FirebaseAuthException catch (e) {
      return Result.err(ServerFailure(e.message ?? e.code));
    } catch (e) {
      return Result.err(ServerFailure(e.toString()));
    }
  }
}
