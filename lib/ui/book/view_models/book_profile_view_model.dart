import 'package:booklub/ui/core/view_models/async_change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:booklub/domain/entities/books/book_item.dart';
import 'package:booklub/infra/books/book_api_repository.dart';

class BookProfileViewModel extends AsyncChangeNotifier<BookItem> {
  final BookApiRepository _bookRepository;

  BookItem? _book;

  BookItem? get book => _book;

  BookProfileViewModel({required BookApiRepository bookRepository})
      : _bookRepository = bookRepository;

  @override
  BookItem? get payload => _book;

  Future<void> setBook(String volumeId) async {
    isLoading = true;
    notifyListeners();

    try {
      _book = await _bookRepository.getBookById(volumeId);
      error = null;
    } catch (e, trace) {
      error = (object: e, stackTrace: trace);
      _book = null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void checkBookLoaded() {
    if (_book == null) {
      throw StateError('Book not loaded');
    }
  }
}
