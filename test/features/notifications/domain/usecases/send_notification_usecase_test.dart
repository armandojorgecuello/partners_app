import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:partners_app/core/error/failure.dart';
import 'package:partners_app/core/result/result.dart';
import 'package:partners_app/features/notifications/domain/repositories/notification_repository.dart';
import 'package:partners_app/features/notifications/domain/usecases/send_notification_usecase.dart';

class _MockNotificationRepository extends Mock implements NotificationRepository {}

void main() {
  late _MockNotificationRepository repository;
  late SendNotificationUseCase useCase;

  setUp(() {
    repository = _MockNotificationRepository();
    useCase = SendNotificationUseCase(repository);
  });

  test('forwards the notification to the repository and returns Ok', () async {
    when(
      () => repository.send(
        recipientUid: any(named: 'recipientUid'),
        actorUid: any(named: 'actorUid'),
        type: any(named: 'type'),
        taskId: any(named: 'taskId'),
        status: any(named: 'status'),
      ),
    ).thenAnswer((_) async {});

    final result = await useCase(
      const SendNotificationParams(recipientUid: 'recipient-1', actorUid: 'actor-1', type: 'new_task'),
    );

    expect(result, isA<Ok<void>>());
    verify(
      () => repository.send(recipientUid: 'recipient-1', actorUid: 'actor-1', type: 'new_task', taskId: null, status: null),
    ).called(1);
  });

  test('maps a repository failure to a ServerFailure', () async {
    when(
      () => repository.send(
        recipientUid: any(named: 'recipientUid'),
        actorUid: any(named: 'actorUid'),
        type: any(named: 'type'),
        taskId: any(named: 'taskId'),
        status: any(named: 'status'),
      ),
    ).thenThrow(Exception('offline'));

    final result = await useCase(
      const SendNotificationParams(recipientUid: 'recipient-1', actorUid: 'actor-1', type: 'new_task'),
    );

    expect(result, isA<Err<void>>());
    expect((result as Err<void>).failure, isA<ServerFailure>());
  });
}
