import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:partners_app/core/error/failure.dart';
import 'package:partners_app/core/result/result.dart';
import 'package:partners_app/features/auth/domain/usecases/ensure_user_document_usecase.dart';
import 'package:partners_app/features/profile/domain/entities/user_profile.dart';
import 'package:partners_app/features/profile/domain/repositories/profile_repository.dart';

class _MockProfileRepository extends Mock implements ProfileRepository {}

class _MockUser extends Mock implements User {}

void main() {
  late _MockProfileRepository repository;
  late _MockUser user;

  setUp(() {
    repository = _MockProfileRepository();
    user = _MockUser();
    when(() => user.uid).thenReturn('uid-1');
    when(() => user.displayName).thenReturn('Jane');
    when(() => user.email).thenReturn('jane@example.com');
    when(() => user.photoURL).thenReturn(null);
  });

  group('EnsureUserDocumentUseCase', () {
    test('creates the profile and reports incomplete when none exists', () async {
      when(() => repository.profileExists('uid-1')).thenAnswer((_) async => false);
      when(
        () => repository.createProfile(
          uid: any(named: 'uid'),
          allowPush: any(named: 'allowPush'),
          name: any(named: 'name'),
          email: any(named: 'email'),
          preferences: any(named: 'preferences'),
          celNumber: any(named: 'celNumber'),
          photoUrl: any(named: 'photoUrl'),
          partnerCheck: any(named: 'partnerCheck'),
          acceptTerms: any(named: 'acceptTerms'),
        ),
      ).thenAnswer((_) async {});

      final useCase = EnsureUserDocumentUseCase(repository);
      final result = await useCase(EnsureUserDocumentParams(user: user));

      expect(result, isA<Ok<bool>>());
      expect((result as Ok<bool>).value, false);
      verify(
        () => repository.createProfile(
          uid: 'uid-1',
          allowPush: true,
          name: 'Jane',
          email: 'jane@example.com',
          preferences: '',
          celNumber: '',
          photoUrl: null,
          partnerCheck: true,
          acceptTerms: true,
        ),
      ).called(1);
    });

    test('reports completeness from the existing profile without recreating it', () async {
      when(() => repository.profileExists('uid-1')).thenAnswer((_) async => true);
      when(() => repository.getProfile('uid-1')).thenAnswer(
        (_) async => const UserProfile(uid: 'uid-1', name: 'Jane', firstLaunch: false),
      );

      final useCase = EnsureUserDocumentUseCase(repository);
      final result = await useCase(EnsureUserDocumentParams(user: user));

      expect(result, isA<Ok<bool>>());
      expect((result as Ok<bool>).value, true);
      verifyNever(
        () => repository.createProfile(
          uid: any(named: 'uid'),
          allowPush: any(named: 'allowPush'),
          partnerCheck: any(named: 'partnerCheck'),
          acceptTerms: any(named: 'acceptTerms'),
        ),
      );
    });

    test('maps repository errors to a ServerFailure', () async {
      when(() => repository.profileExists('uid-1')).thenThrow(Exception('offline'));

      final useCase = EnsureUserDocumentUseCase(repository);
      final result = await useCase(EnsureUserDocumentParams(user: user));

      expect(result, isA<Err<bool>>());
      expect((result as Err<bool>).failure, isA<ServerFailure>());
    });
  });
}
