import 'package:booklub/ui/core/view_models/async_change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:booklub/domain/entities/books/book_item.dart';
import 'package:booklub/infra/books/book_api_repository.dart';

class BookProfileViewModel extends AsyncChangeNotifier<BookItem> {
  final BookApiRepository _bookRepository;
  final String volumeId;

  BookProfileViewModel({
    required BookApiRepository bookRepository,
    required this.volumeId,
  }) : _bookRepository = bookRepository {
    _setBook(volumeId);
  }

  BookItem? _book;

  @override
  BookItem? get payload => _book;

  BookItem? get book => payload;

  Future<void> _setBook(String volumeId) async {
    isLoading = true;
    notifyListeners();
    print('entrou no setBook com volumeId: $volumeId');
    try {
      print('entrou no try do setBook');
      final bookData = await _bookRepository.getBookById(volumeId);
      _book = bookData;
      error = null;
    } catch (e, trace) {
      print('Erro ao carregar livro: $e\nStack trace: $trace');
      error = (object: e, stackTrace: trace);
      _book = null;
    } finally {
      print('Finalizando o carregamento do livro');
      isLoading = false;
      print('Book loaded: $_book');
      notifyListeners();
    }
  }

  void checkBookLoaded() {
    if (_book == null) {
      throw StateError(
        'Book id '
        ' $volumeId '
        ' not loaded',
      );
    }
  }
}
