import 'package:flutter/material.dart';

class AsyncBuilder<T> extends StatelessWidget {

  final Future<T> future;

  final Widget Function(T data) onRetrieved;

  final Widget Function() onLoading;

  final Widget Function(Object error, StackTrace stackTrace) onError;

  const AsyncBuilder({
    super.key,
    required this.future,
    required this.onRetrieved,
    required this.onLoading,
    required this.onError,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) => switch (snapshot.connectionState) {
        ConnectionState.waiting => onLoading(),
        ConnectionState.done when snapshot.hasError => onError(
            snapshot.error!,
            snapshot.stackTrace!
        ),
        ConnectionState.done when snapshot.hasData => onRetrieved(
          snapshot.data as T
        ),
        _ => SizedBox.shrink(),
      },
    );
  }

}
