import 'package:partners_app/core/error/failure.dart';
import 'package:partners_app/core/result/result.dart';
import 'package:partners_app/core/usecase/usecase.dart';
import 'package:partners_app/features/auth/domain/repositories/auth_repository.dart';

class SignOutUseCase extends UseCase<void, NoParams> {
  final AuthRepository _authRepository;

  SignOutUseCase(this._authRepository);

  @override
  Future<Result<void>> call(NoParams params) async {
    try {
      await _authRepository.signOut();
      return const Result.ok(null);
    } catch (e) {
      return Result.err(ServerFailure(e.toString()));
    }
  }
}
