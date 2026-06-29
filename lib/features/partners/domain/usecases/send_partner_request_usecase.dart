import 'package:partners_app/core/error/failure.dart';
import 'package:partners_app/core/result/result.dart';
import 'package:partners_app/core/usecase/usecase.dart';
import 'package:partners_app/features/notifications/domain/usecases/send_notification_usecase.dart';
import 'package:partners_app/features/partners/domain/repositories/partner_repository.dart';

class SendPartnerRequestParams {
  final String senderUid;
  final String receiverUid;

  const SendPartnerRequestParams({required this.senderUid, required this.receiverUid});
}

/// `message` on the returned [ValidationFailure] is one of `'request_exists'`
/// or `'already_partners'` — machine-checkable codes the presentation layer
/// maps to the right localized dialog, replacing the duplicate/self checks
/// that used to live in lib/utils/partner_request_validation.dart.
class SendPartnerRequestUseCase extends UseCase<void, SendPartnerRequestParams> {
  final PartnerRepository _repository;
  final SendNotificationUseCase _sendNotification;

  SendPartnerRequestUseCase(this._repository, this._sendNotification);

  @override
  Future<Result<void>> call(SendPartnerRequestParams params) async {
    try {
      final alreadyRequested = await _repository.requestExists(
        senderUid: params.senderUid,
        receiverUid: params.receiverUid,
      );
      if (alreadyRequested) {
        return const Result.err(ValidationFailure('request_exists'));
      }
      final alreadyPartners = await _repository.isAlreadyPartner(
        senderUid: params.senderUid,
        receiverUid: params.receiverUid,
      );
      if (alreadyPartners) {
        return const Result.err(ValidationFailure('already_partners'));
      }
      await _repository.createRequest(senderUid: params.senderUid, receiverUid: params.receiverUid);
      await _sendNotification(
        SendNotificationParams(recipientUid: params.receiverUid, actorUid: params.senderUid, type: 'partner_request'),
      );
      return const Result.ok(null);
    } catch (e) {
      return Result.err(ServerFailure(e.toString()));
    }
  }
}
