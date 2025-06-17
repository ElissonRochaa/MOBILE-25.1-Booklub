import 'package:flutter/material.dart';
import 'package:booklub/domain/entities/books/book_item.dart';
import 'package:booklub/infra/books/book_api_repository.dart';

class BookProfileViewModel extends ChangeNotifier {
  final BookApiRepository _bookRepository;

  BookItem? _book;

  BookItem? get book => _book;

  BookProfileViewModel({required BookApiRepository bookRepository})
      : _bookRepository = bookRepository;

  Future<void> setBook(String isbn) async {
    final paginator = await _bookRepository.searchBooks(isbn: isbn, size: 1);
    if (paginator.content.isNotEmpty) {
      _book = paginator.content.first;
    } else {
      _book = null;
    }
    notifyListeners();
  }
}
