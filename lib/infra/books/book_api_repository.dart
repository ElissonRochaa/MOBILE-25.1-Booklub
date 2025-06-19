import 'dart:convert';
import 'dart:io';

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
  }) : _apiUrl = apiUrl, _authRepository = authRepository;

  Future<Paginator<BookItem>> searchBooks({
    String? intitle,
    String? inauthor,
    String? inpublisher,
    String? subject,
    String? isbn,
    int page = 0,
    int size = 10,
  }) async {
    final authToken = (await _authRepository.getAuthData())!.token;

    return Paginator.create<BookItem>(size, (page, pageSize) async {
      final uri = Uri.parse(
        '$_apiUrl/api/v1/books/search',
      ).replace(
        queryParameters: {
          if (intitle != null && intitle.isNotEmpty) 'intitle': intitle,
          if (inauthor != null && inauthor.isNotEmpty) 'inauthor': inauthor,
          if (inpublisher != null && inpublisher.isNotEmpty) 'inpublisher': inpublisher,
          if (subject != null && subject.isNotEmpty) 'subject': subject,
          if (isbn != null && isbn.isNotEmpty) 'isbn': isbn,
          'page': page.toString(),
          'size': pageSize.toString(),
        }
      );

      final response = await http.get(
        uri,
        headers: {
          HttpHeaders.contentTypeHeader: ContentType.json.toString(),
          HttpHeaders.authorizationHeader: authToken.toString(),
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Erro ao buscar livros');
      }

      return Page<BookItem>.fromJson(
        jsonDecode(response.body),
        (json) => BookItem.fromJson(json as Map<String, dynamic>),
      );
    });
  }
}
