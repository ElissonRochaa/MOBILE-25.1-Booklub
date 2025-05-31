import 'dart:convert';
import 'dart:io';
import 'package:booklub/domain/entities/users/user.dart';
import 'package:booklub/infra/auth/auth_repository.dart';
import 'package:booklub/utils/pagination/paginator.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:booklub/domain/entities/users/auth_data.dart';
import 'package:booklub/domain/entities/users/user_creation_dto.dart';
import 'package:booklub/utils/http/http_error_dto.dart';
import 'package:http/http.dart' as http;
import 'package:booklub/utils/pagination/page.dart';
import 'package:logger/logger.dart';

class UserException implements Exception {
  final String message;

  UserException(this.message);

  @override
  String toString() => 'UserException: $message';
}

class UserRepository {
  final _logger = Logger();

  final String _apiUrl;

  final AuthRepository authRepository;

  UserRepository({required this.authRepository, required String apiUrl})
    : _apiUrl = apiUrl;

  Future<Paginator<User>> findByUsernameContaining(
    String username,
    int pageSize,
  ) async {
    final authData = await authRepository.getAuthData();

    if (authData == null) {
      throw Exception('O usuário não está autenticado');
    }

    final accessToken = authData.token.accessToken;

    return Paginator.create(pageSize, (pageIdx, pageSize) async {
      final uri = Uri.parse('$_apiUrl/api/v1/user/search').replace(
        queryParameters: {
          'username': username,
          'page': pageIdx.toString(),
          'size': pageSize.toString(),
          'sort': 'username,asc',
        },
      );
      final response = await http.get(
        uri,
        headers: {
          HttpHeaders.contentTypeHeader: ContentType.json.toString(),
          HttpHeaders.authorizationHeader: 'Bearer $accessToken',
        },
      );

      final json = jsonDecode(response.body);
      final page = Page<User>.fromJson(
        json,
        (json) => User.fromJson(json as Map<String, dynamic>),
      );

      return page;
    });
  }
}
