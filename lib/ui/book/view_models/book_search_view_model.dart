import 'package:flutter/cupertino.dart';
import 'package:booklub/domain/entities/books/book_item.dart';
import 'package:booklub/infra/books/book_api_repository.dart';
import 'package:booklub/utils/pagination/paginator.dart';

class BookSearchViewModel extends ChangeNotifier {
  final BookApiRepository bookRepository;

  BookSearchViewModel({required this.bookRepository});

  Future<Paginator<BookItem>> searchBooksByTitle(
    String title,
    int pageSize,
  ) async {
    return bookRepository.searchBooks(intitle: title, size: pageSize);
  }

  Future<Paginator<BookItem>> searchBooksByAuthor({
    required String title,
    required String author,
    int pageSize = 10,
  }) async {
    return bookRepository.searchBooks(
      intitle: title,
      inauthor: author,
      size: pageSize,
    );
  }

  Future<Paginator<BookItem>> searchBooksByPublisher({
    required String title,
    required String publisher,
    int pageSize = 10,
  }) async {
    return bookRepository.searchBooks(
      intitle: title,
      inpublisher: publisher,
      size: pageSize,
    );
  }

  Future<Paginator<BookItem>> searchBooksBySubject({
    required String title,
    required String subject,
    int pageSize = 10,
  }) async {
    return bookRepository.searchBooks(
      intitle: title,
      subject: subject,
      size: pageSize,
    );
  }

  Future<Paginator<BookItem>> searchBooksByIsbn({
    required String title,
    required String isbn,
    int pageSize = 10,
  }) async {
    return bookRepository.searchBooks(
      intitle: title,
      isbn: isbn,
      size: pageSize,
    );
  }

  Future<Paginator<BookItem>> searchBooksByPublishedDate({
    required String title,
    required String publishedDate,
    int pageSize = 10,
  }) async {
    return bookRepository.searchBooks(
      intitle: title,
      publishedDate: publishedDate,
      size: pageSize,
    );
  }
}
