import 'package:partners_app/core/error/failure.dart';
import 'package:partners_app/core/result/result.dart';
import 'package:partners_app/core/usecase/usecase.dart';
import 'package:partners_app/features/notifications/domain/usecases/send_notification_usecase.dart';
import 'package:partners_app/features/partners/domain/repositories/partner_repository.dart';

class AcceptPartnerRequestParams {
  final String receiverUid;
  final String senderUid;

  const AcceptPartnerRequestParams({required this.receiverUid, required this.senderUid});
}

class AcceptPartnerRequestUseCase extends UseCase<void, AcceptPartnerRequestParams> {
  final PartnerRepository _repository;
  final SendNotificationUseCase _sendNotification;

  AcceptPartnerRequestUseCase(this._repository, this._sendNotification);

  @override
  Future<Result<void>> call(AcceptPartnerRequestParams params) async {
    try {
      await _repository.acceptRequest(receiverUid: params.receiverUid, senderUid: params.senderUid);
      await _sendNotification(
        SendNotificationParams(recipientUid: params.senderUid, actorUid: params.receiverUid, type: 'partner_accepted'),
      );
      return const Result.ok(null);
    } catch (e) {
      return Result.err(ServerFailure(e.toString()));
    }
  }
}
