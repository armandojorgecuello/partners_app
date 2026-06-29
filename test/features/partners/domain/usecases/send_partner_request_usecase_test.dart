import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:partners_app/core/error/failure.dart';
import 'package:partners_app/core/result/result.dart';
import 'package:partners_app/features/notifications/domain/usecases/send_notification_usecase.dart';
import 'package:partners_app/features/partners/domain/repositories/partner_repository.dart';
import 'package:partners_app/features/partners/domain/usecases/send_partner_request_usecase.dart';

class _MockPartnerRepository extends Mock implements PartnerRepository {}

class _MockSendNotificationUseCase extends Mock implements SendNotificationUseCase {}

void main() {
  late _MockPartnerRepository repository;
  late _MockSendNotificationUseCase sendNotification;
  late SendPartnerRequestUseCase useCase;

  const params = SendPartnerRequestParams(senderUid: 'sender-1', receiverUid: 'receiver-1');

  setUpAll(() {
    registerFallbackValue(const SendNotificationParams(recipientUid: '', actorUid: '', type: ''));
  });

  setUp(() {
    repository = _MockPartnerRepository();
    sendNotification = _MockSendNotificationUseCase();
    useCase = SendPartnerRequestUseCase(repository, sendNotification);
  });

  test('rejects with request_exists when a request is already pending', () async {
    when(() => repository.requestExists(senderUid: any(named: 'senderUid'), receiverUid: any(named: 'receiverUid')))
        .thenAnswer((_) async => true);

    final result = await useCase(params);

    expect(result, isA<Err<void>>());
    final failure = (result as Err<void>).failure;
    expect(failure, isA<ValidationFailure>());
    expect((failure as ValidationFailure).message, 'request_exists');
    verifyNever(() => repository.createRequest(senderUid: any(named: 'senderUid'), receiverUid: any(named: 'receiverUid')));
  });

  test('rejects with already_partners when the pair is already linked', () async {
    when(() => repository.requestExists(senderUid: any(named: 'senderUid'), receiverUid: any(named: 'receiverUid')))
        .thenAnswer((_) async => false);
    when(() => repository.isAlreadyPartner(senderUid: any(named: 'senderUid'), receiverUid: any(named: 'receiverUid')))
        .thenAnswer((_) async => true);

    final result = await useCase(params);

    expect(result, isA<Err<void>>());
    final failure = (result as Err<void>).failure as ValidationFailure;
    expect(failure.message, 'already_partners');
  });

  test('creates the request and notifies the receiver when clear', () async {
    when(() => repository.requestExists(senderUid: any(named: 'senderUid'), receiverUid: any(named: 'receiverUid')))
        .thenAnswer((_) async => false);
    when(() => repository.isAlreadyPartner(senderUid: any(named: 'senderUid'), receiverUid: any(named: 'receiverUid')))
        .thenAnswer((_) async => false);
    when(() => repository.createRequest(senderUid: any(named: 'senderUid'), receiverUid: any(named: 'receiverUid')))
        .thenAnswer((_) async {});
    when(() => sendNotification(any())).thenAnswer((_) async => const Result.ok(null));

    final result = await useCase(params);

    expect(result, isA<Ok<void>>());
    verify(
      () => sendNotification(
        const SendNotificationParams(recipientUid: 'receiver-1', actorUid: 'sender-1', type: 'partner_request'),
      ),
    ).called(1);
  });
}
