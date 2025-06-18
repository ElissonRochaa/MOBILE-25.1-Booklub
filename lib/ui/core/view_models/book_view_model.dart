import 'package:booklub/domain/entities/books/book_item.dart';
import 'package:booklub/infra/books/book_api_repository.dart';

class BookViewModel {
  // ignore: unused_field
  final BookApiRepository _repository;

  BookViewModel({
    required BookApiRepository repository,
  }) : _repository = repository;

  Future<BookItem?> getBook(String id) async {
    // TODO Implementar chamada à API
    return BookItem(
      title: 'O Mundo de Sopheia',
      authors: 'Jostein Gaarder',
      description: 'Uma descrição qualquer',
      isbn: '978-8535921892',
      thumbnail: 'https://m.media-amazon.com/images/I/41gy6VSjqbL._UF1000,1000_QL80_.jpg'
    );
  }

}