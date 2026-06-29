import 'package:partners_app/core/error/failure.dart';

/// Outcome of a one-shot write/command use case: either a value or a [Failure].
/// Streams (`watch*` repository methods) intentionally don't use this — they
/// emit raw entities and let Riverpod's `AsyncValue` carry loading/error state.
sealed class Result<T> {
  const Result();

  const factory Result.ok(T value) = Ok<T>;

  const factory Result.err(Failure failure) = Err<T>;

  bool get isOk => this is Ok<T>;

  R fold<R>(R Function(T value) onOk, R Function(Failure failure) onErr) {
    final self = this;
    if (self is Ok<T>) return onOk(self.value);
    return onErr((self as Err<T>).failure);
  }
}

final class Ok<T> extends Result<T> {
  final T value;

  const Ok(this.value);
}

final class Err<T> extends Result<T> {
  final Failure failure;

  const Err(this.failure);
}
