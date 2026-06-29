import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partners_app/design_system/atoms/loading_indicator.dart';

/// Riverpod-native replacement for lib/src/widget/async_state_view.dart
/// (which rendered loading/error/data states off a raw `AsyncSnapshot`).
class AsyncValueView<T> extends StatelessWidget {
  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final Widget? loading;
  final String Function(Object error)? errorMessage;

  const AsyncValueView({
    super.key,
    required this.value,
    required this.data,
    this.loading,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      loading: () => loading ?? const LoadingIndicator(),
      error: (error, _) => Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            errorMessage?.call(error) ?? 'Ocurrió un error. Intenta de nuevo.',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
