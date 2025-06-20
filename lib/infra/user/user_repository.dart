import 'dart:convert';
import 'dart:io';

import 'package:booklub/domain/entities/users/auth_data.dart';
import 'package:booklub/domain/entities/users/user.dart';
import 'package:booklub/domain/entities/users/user_update_dto.dart';
import 'package:booklub/infra/auth/auth_repository.dart';
import 'package:booklub/utils/http/http_error_dto.dart';
import 'package:booklub/utils/pagination/page.dart';
import 'package:booklub/utils/pagination/paginator.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class UserException implements Exception {
  final String message;

  UserException(this.message);

  @override
  String toString() => 'UserException: $message';
}

class UserRepository {

  final String _apiUrl;

  final _logger = Logger();

  final AuthRepository _authRepository;

  UserRepository({
    required AuthRepository authRepository,
    required String apiUrl
  }): _authRepository = authRepository, _apiUrl = apiUrl;

  Future<Paginator<User>> findByUsernameContaining(
    String username,
    int pageSize,
  ) async {
    final authData = await _authRepository.getAuthData();

    if (authData == null) {
      throw Exception('O usuário não está autenticado');
    }

    final accessToken = authData.token.accessToken;

    return Paginator.create(pageSize, (pageIdx, pageSize) async {
      final response = await http.get(
        Uri.parse(
          '$_apiUrl/api/v1/user/search',
        ).replace(queryParameters: {'username': username}),
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

  Future<User> findById(String id) async {
    final authToken = (await _authRepository.getAuthData())!.token;

    final uri = Uri.parse('$_apiUrl/api/v1/user/$id');

    final response = await http.get(
      uri,
      headers: {
        HttpHeaders.contentTypeHeader: ContentType.json.toString(),
        HttpHeaders.authorizationHeader: authToken.toString(),
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch user with ID $id');
    }

    return User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  Future<void> update(UserUpdateDTO dto) async {
    final authData = (await _authRepository.getAuthData())!;
    final authToken = authData.token;

    final uri = Uri.parse('$_apiUrl/api/v1/user/${dto.id}');
    final request = http.MultipartRequest('PUT', uri);

    dto.fillMultipartRequest(request);

    request.headers[HttpHeaders.authorizationHeader] = authToken.toString();

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      _logger.i('Usuário registrado com sucesso!');
      final json = jsonDecode(response.body);
      final updatedUser = User.fromJson(json);

      final newAtuhData = AuthData(user: updatedUser, token: authToken);

      await _authRepository.saveAuthData(newAtuhData);

      return; 
    }

    throw UserException('Erro ao atualizar usuário');
  }

}
