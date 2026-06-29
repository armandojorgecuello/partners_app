import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:partners_app/core/error/failure.dart';
import 'package:partners_app/core/result/result.dart';
import 'package:partners_app/features/notifications/domain/usecases/send_notification_usecase.dart';
import 'package:partners_app/features/tasks/domain/repositories/task_repository.dart';
import 'package:partners_app/features/tasks/domain/usecases/create_task_usecase.dart';

class _MockTaskRepository extends Mock implements TaskRepository {}

class _MockSendNotificationUseCase extends Mock implements SendNotificationUseCase {}

void main() {
  late _MockTaskRepository taskRepository;
  late _MockSendNotificationUseCase sendNotification;
  late CreateTaskUseCase useCase;
  final image = File('reward.jpg');
  final deliveryTime = DateTime(2026, 1, 1);

  setUpAll(() {
    registerFallbackValue(File(''));
    registerFallbackValue(const SendNotificationParams(recipientUid: '', actorUid: '', type: ''));
  });

  setUp(() {
    taskRepository = _MockTaskRepository();
    sendNotification = _MockSendNotificationUseCase();
    useCase = CreateTaskUseCase(taskRepository, sendNotification);
  });

  test('creates the task, notifies the receiver, and returns the new id', () async {
    when(
      () => taskRepository.createTask(
        image: any(named: 'image'),
        title: any(named: 'title'),
        senderUid: any(named: 'senderUid'),
        receiverUid: any(named: 'receiverUid'),
        deliveryTime: any(named: 'deliveryTime'),
        reward: any(named: 'reward'),
      ),
    ).thenAnswer((_) async => 'task-1');
    when(() => sendNotification(any())).thenAnswer((_) async => const Result.ok(null));

    final result = await useCase(
      CreateTaskParams(
        image: image,
        title: 'Clean the kitchen',
        senderUid: 'sender-1',
        receiverUid: 'receiver-1',
        deliveryTime: deliveryTime,
        reward: '5 coffees',
      ),
    );

    expect(result, isA<Ok<String>>());
    expect((result as Ok<String>).value, 'task-1');
    verify(
      () => sendNotification(
        const SendNotificationParams(recipientUid: 'receiver-1', actorUid: 'sender-1', type: 'new_task'),
      ),
    ).called(1);
  });

  test('maps a repository failure to a ServerFailure without notifying', () async {
    when(
      () => taskRepository.createTask(
        image: any(named: 'image'),
        title: any(named: 'title'),
        senderUid: any(named: 'senderUid'),
        receiverUid: any(named: 'receiverUid'),
        deliveryTime: any(named: 'deliveryTime'),
        reward: any(named: 'reward'),
      ),
    ).thenThrow(Exception('storage error'));

    final result = await useCase(
      CreateTaskParams(
        image: image,
        title: 'Clean the kitchen',
        senderUid: 'sender-1',
        receiverUid: 'receiver-1',
        deliveryTime: deliveryTime,
        reward: '5 coffees',
      ),
    );

    expect(result, isA<Err<String>>());
    expect((result as Err<String>).failure, isA<ServerFailure>());
    verifyNever(() => sendNotification(any()));
  });
}
