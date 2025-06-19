import 'package:booklub/ui/core/view_models/async_change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AsyncBuilderException implements Exception {

  final String message;

  const AsyncBuilderException(this.message);

  @override
  String toString() => 'AsyncBuilderException: $message';

}

enum AsyncBuilderMode {future, asyncChangeNotifier}

class AsyncBuilder<T> extends StatelessWidget {

  final Future<T>? future;

  final AsyncChangeNotifier<T>? asyncChangeNotifier;

  final AsyncBuilderMode mode;

  final Widget Function(T data) onRetrieved;

  final Widget Function() onLoading;

  final Widget Function(Object error, StackTrace stackTrace) onError;

  const AsyncBuilder({
    super.key,
    required this.future,
    required this.onRetrieved,
    required this.onLoading,
    required this.onError,
  }): mode = AsyncBuilderMode.future, asyncChangeNotifier = null;

  const AsyncBuilder.fromAsyncChangeNotifier({
    super.key,
    required this.asyncChangeNotifier,
    required this.onRetrieved,
    required this.onLoading,
    required this.onError,
  }): mode = AsyncBuilderMode.asyncChangeNotifier, future = null;

  @override
  Widget build(BuildContext context) => switch (mode) {
    AsyncBuilderMode.future => Builder(builder: _buildFromFuture),
    AsyncBuilderMode.asyncChangeNotifier => Builder(builder: _buildFromAsyncChangeNotifier),
  };

  Widget _buildFromFuture(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) => switch (snapshot.connectionState) {
        ConnectionState.waiting => onLoading(),
        ConnectionState.done => (snapshot.hasError
          ? onError(
            snapshot.error!,
            snapshot.stackTrace!
          )
          : onRetrieved(
            snapshot.data as T
          )
        ),
        _ => throw AsyncBuilderException('Could not resolve future.'),
      },
    );
  }

  Widget _buildFromAsyncChangeNotifier(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: asyncChangeNotifier!,
      child: Consumer<AsyncChangeNotifier<T>>(
        builder: (context, notifier, _) => switch (notifier) {
          _ when notifier.isCompleted => onRetrieved(notifier.payload as T),
          _ when notifier.isLoading => onLoading(),
          _ when notifier.hasError => onError(
            notifier.error!.object,
            notifier.error!.stackTrace
          ),
          _ => throw AsyncBuilderException('Could not resolve future.')
        }
      ),
    );
  }

}


