import 'package:partners_app/core/result/result.dart';

/// Base contract for one-shot use cases (write/command actions).
abstract class UseCase<ResultType, Params> {
  Future<Result<ResultType>> call(Params params);
}

class NoParams {
  const NoParams();
}
