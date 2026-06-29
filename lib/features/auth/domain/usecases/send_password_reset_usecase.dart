import 'package:firebase_auth/firebase_auth.dart';
import 'package:partners_app/core/error/failure.dart';
import 'package:partners_app/core/result/result.dart';
import 'package:partners_app/core/usecase/usecase.dart';
import 'package:partners_app/features/auth/domain/repositories/auth_repository.dart';

class SendPasswordResetUseCase extends UseCase<void, String> {
  final AuthRepository _authRepository;

  SendPasswordResetUseCase(this._authRepository);

  @override
  Future<Result<void>> call(String email) async {
    try {
      await _authRepository.sendPasswordResetEmail(email);
      return const Result.ok(null);
    } on FirebaseAuthException catch (e) {
      return Result.err(ServerFailure(e.message ?? e.code));
    } catch (e) {
      return Result.err(ServerFailure(e.toString()));
    }
  }
}
