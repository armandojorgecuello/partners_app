import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:partners_app/core/error/failure.dart';
import 'package:partners_app/core/result/result.dart';
import 'package:partners_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:partners_app/features/profile/domain/usecases/update_profile_usecase.dart';

class _MockProfileRepository extends Mock implements ProfileRepository {}

void main() {
  late _MockProfileRepository repository;
  late UpdateProfileUseCase useCase;

  setUp(() {
    repository = _MockProfileRepository();
    useCase = UpdateProfileUseCase(repository);
  });

  test('saves the profile fields and returns Ok on success', () async {
    when(
      () => repository.updateProfile(
        uid: any(named: 'uid'),
        name: any(named: 'name'),
        email: any(named: 'email'),
        preferences: any(named: 'preferences'),
        celNumber: any(named: 'celNumber'),
      ),
    ).thenAnswer((_) async {});

    final result = await useCase(
      const UpdateProfileParams(uid: 'uid-1', name: 'Jane', email: 'jane@example.com'),
    );

    expect(result, isA<Ok<void>>());
    verify(
      () => repository.updateProfile(
        uid: 'uid-1',
        name: 'Jane',
        email: 'jane@example.com',
        preferences: null,
        celNumber: null,
      ),
    ).called(1);
  });

  test('maps a repository failure to a ServerFailure', () async {
    when(
      () => repository.updateProfile(
        uid: any(named: 'uid'),
        name: any(named: 'name'),
        email: any(named: 'email'),
        preferences: any(named: 'preferences'),
        celNumber: any(named: 'celNumber'),
      ),
    ).thenThrow(Exception('network down'));

    final result = await useCase(const UpdateProfileParams(uid: 'uid-1'));

    expect(result, isA<Err<void>>());
    expect((result as Err<void>).failure, isA<ServerFailure>());
  });
}
