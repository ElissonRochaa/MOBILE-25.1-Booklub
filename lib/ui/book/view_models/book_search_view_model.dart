import 'package:booklub/infra/books/book_api_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:booklub/domain/entities/books/book_item.dart';
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

  Future<Paginator<BookItem>> searchBooksByAuthor(
    String author,
    int pageSize,
  ) async {
    return bookRepository.searchBooks(inauthor: author, size: pageSize);
  }

  Future<Paginator<BookItem>> searchBooksByPublisher(
    String publisher,
    int pageSize,
  ) async {
    return bookRepository.searchBooks(inpublisher: publisher, size: pageSize);
  }

  //é assunto tema tipo "ficção", "terror"
  Future<Paginator<BookItem>> searchBooksBySubject(
    String subject,
    int pageSize,
  ) async {
    return bookRepository.searchBooks(subject: subject, size: pageSize);
  }

  Future<Paginator<BookItem>> searchBooksByIsbn(
    String isbn,
    int pageSize,
  ) async {
    return bookRepository.searchBooks(isbn: isbn, size: pageSize);
  }
}
