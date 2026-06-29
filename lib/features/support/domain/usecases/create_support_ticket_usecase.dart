import 'package:partners_app/core/error/failure.dart';
import 'package:partners_app/core/result/result.dart';
import 'package:partners_app/core/usecase/usecase.dart';
import 'package:partners_app/features/support/domain/repositories/support_repository.dart';

class CreateSupportTicketParams {
  final String uid;
  final String subject;
  final String description;

  const CreateSupportTicketParams({required this.uid, required this.subject, required this.description});
}

class CreateSupportTicketUseCase extends UseCase<String, CreateSupportTicketParams> {
  final SupportRepository _repository;

  CreateSupportTicketUseCase(this._repository);

  @override
  Future<Result<String>> call(CreateSupportTicketParams params) async {
    try {
      final ticketId = await _repository.createTicket(
        uid: params.uid,
        subject: params.subject,
        description: params.description,
      );
      return Result.ok(ticketId);
    } catch (e) {
      return Result.err(ServerFailure(e.toString()));
    }
  }
}
