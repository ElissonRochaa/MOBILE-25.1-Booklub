import 'dart:convert';

import 'package:booklub/domain/entities/books/book_item.dart';
import 'package:booklub/infra/auth/auth_repository.dart';
import 'package:booklub/utils/pagination/page.dart';
import 'package:booklub/utils/pagination/paginator.dart';
import 'package:http/http.dart' as http;

class BookApiRepository {
  final String _apiUrl;

  final AuthRepository _authRepository;

  BookApiRepository({
    required String apiUrl,
    required AuthRepository authRepository,
  }) : _apiUrl = apiUrl,
       _authRepository = authRepository;

  Future<Paginator<BookItem>> searchBooks({
    String? intitle,
    String? inauthor,
    String? inpublisher,
    String? subject,
    String? isbn,
    int page = 0,
    int size = 10,
  }) async {
    final queryParameters = {
      if (intitle != null && intitle.isNotEmpty) 'intitle': intitle,
      if (inauthor != null && inauthor.isNotEmpty) 'inauthor': inauthor,
      if (inpublisher != null && inpublisher.isNotEmpty)
        'inpublisher': inpublisher,
      if (subject != null && subject.isNotEmpty) 'subject': subject,
      if (isbn != null && isbn.isNotEmpty) 'isbn': isbn,
    };

    final authData = await _authRepository.getAuthData();
    if (authData == null) {
      throw Exception('O usuário não está autenticado');
    }
    final token = authData.token.accessToken;

    // vai montar o corpo da requisição, que é o que vai ser enviado para a api, enviar para o endpoint de buscar livros, receber a resposta q é uma pageModel<BookItem> e transformar esse Json em um objeto BookItem. Para enfim encapsular esses resultados em um Page<BookItem>, que é o que o Paginator precisa.
    Future<Page<BookItem>> fetchPage(int page, int size) async {
      final uri = Uri.parse(
        '$_apiUrl/api/v1/books/search?page=$page&size=$size',
      );

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      //transforma o map em json (monta o corpo da requisição)
      final body = jsonEncode(queryParameters);

      final response = await http.post(uri, headers: headers, body: body);

      if (response.statusCode == 200) {
        //a api respondeu, então, transforma essa resposta (em json) de volta a um map.
        //oq vem de um jsonDecode é um Map<String,dynamic> ou um List<dynamic>. são dados crus.
        // por isso que não dá para fazer direto list<bookitem>. o dart ainda não sabe que tipo de lista é essa.
        final json = jsonDecode(response.body);
        //a api vai mandar uma lista de livros dentro do content. entao precisamos extrair essa lista.
        final List<dynamic> contentJson = json['content'];
        //aqui transforma cada item json em um bookitem (objt dart). esse metodo fromJson já sabe como fazer isso, pois foi implementado na classe BookItem.
        final List<BookItem> items =
            contentJson
                .map<BookItem>((item) => BookItem.fromJson(item))
                .toList();
        final totalItems = json['totalElements'];

        // aqui, cria uma Page<BookItem> que é o que o Paginator precisa.
        return Page<BookItem>(
          content: items,
          pageInfo: PageInfo(
            size: size,
            number: page,
            totalElements: totalItems,
            totalPages: (totalItems / size).ceil(),
          ),
        );
      } else {
        throw Exception('Erro ao buscar livros: ${response.statusCode}');
      }
    }

    return Paginator.create<BookItem>(size, fetchPage);
  }
}
