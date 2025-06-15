import 'package:flutter/cupertino.dart';

abstract class AsyncChangeNotifier<T> extends ChangeNotifier {

  T? get payload;

  bool isLoading = false;

  bool get isCompleted => !isLoading;

  ({Object object, StackTrace stackTrace})? error;

  bool get hasError => error != null;

}