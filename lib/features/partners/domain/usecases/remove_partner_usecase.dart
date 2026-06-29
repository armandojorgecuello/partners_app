import 'package:partners_app/core/error/failure.dart';
import 'package:partners_app/core/result/result.dart';
import 'package:partners_app/core/usecase/usecase.dart';
import 'package:partners_app/features/partners/domain/repositories/partner_repository.dart';
import 'package:partners_app/features/tasks/domain/repositories/task_repository.dart';

class RemovePartnerParams {
  final String uid;
  final String partnerUid;

  const RemovePartnerParams({required this.uid, required this.partnerUid});
}

/// Cascades the task cleanup that used to be two separate, easy-to-forget
/// calls (`deletePartnerAccepted` + `deleteTasksPartner`) at the call site in
/// partner_accept_list.dart. Depends on features/tasks' domain repository
/// (one-directional: partners -> tasks).
class RemovePartnerUseCase extends UseCase<void, RemovePartnerParams> {
  final PartnerRepository _partnerRepository;
  final TaskRepository _taskRepository;

  RemovePartnerUseCase(this._partnerRepository, this._taskRepository);

  @override
  Future<Result<void>> call(RemovePartnerParams params) async {
    try {
      await _partnerRepository.removePartnerLink(params.uid, params.partnerUid);
      await _taskRepository.deleteTasksBetween(params.uid, params.partnerUid);
      return const Result.ok(null);
    } catch (e) {
      return Result.err(ServerFailure(e.toString()));
    }
  }
}
