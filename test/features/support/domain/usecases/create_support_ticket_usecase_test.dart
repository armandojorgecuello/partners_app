import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:partners_app/core/error/failure.dart';
import 'package:partners_app/core/result/result.dart';
import 'package:partners_app/features/support/domain/repositories/support_repository.dart';
import 'package:partners_app/features/support/domain/usecases/create_support_ticket_usecase.dart';

class _MockSupportRepository extends Mock implements SupportRepository {}

void main() {
  late _MockSupportRepository repository;
  late CreateSupportTicketUseCase useCase;

  setUp(() {
    repository = _MockSupportRepository();
    useCase = CreateSupportTicketUseCase(repository);
  });

  test('creates the ticket and returns its id on success', () async {
    when(
      () => repository.createTicket(
        uid: any(named: 'uid'),
        subject: any(named: 'subject'),
        description: any(named: 'description'),
      ),
    ).thenAnswer((_) async => 'ABC123');

    final result = await useCase(
      const CreateSupportTicketParams(uid: 'uid-1', subject: 'Help', description: 'Something is broken'),
    );

    expect(result, isA<Ok<String>>());
    expect((result as Ok<String>).value, 'ABC123');
  });

  test('maps a repository failure to a ServerFailure', () async {
    when(
      () => repository.createTicket(
        uid: any(named: 'uid'),
        subject: any(named: 'subject'),
        description: any(named: 'description'),
      ),
    ).thenThrow(Exception('write failed'));

    final result = await useCase(
      const CreateSupportTicketParams(uid: 'uid-1', subject: 'Help', description: 'Something is broken'),
    );

    expect(result, isA<Err<String>>());
    expect((result as Err<String>).failure, isA<ServerFailure>());
  });
}
