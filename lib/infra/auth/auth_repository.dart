import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:booklub/domain/entities/users/auth_data.dart';
import 'package:booklub/domain/entities/users/user_creation_dto.dart';
import 'package:booklub/utils/http/http_error_dto.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class AuthException implements Exception {

  final String message;

  AuthException(this.message);

  @override
  String toString() => 'AuthException: $message';

}

class AuthRepository {

  final _logger = Logger();

  final _secureStorage = const FlutterSecureStorage();

  static const _authDataKey = 'auth_data';

  final String _apiUrl;

  AuthRepository({
    required String apiUrl,
  }): _apiUrl = apiUrl;

  Future<AuthData> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$_apiUrl/api/v1/auth/login'),
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
      headers: {
        HttpHeaders.contentTypeHeader: ContentType.json.toString(),
      }
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return AuthData.fromJson(json);
    } else {
      throw Exception('Falha ao fazer login: ${response.statusCode}');
    }
  }

  Future<void> recoverPasswordViaEmail(String email) async {
    final response = await http.put(
      Uri.parse('$_apiUrl/api/v1/auth/recover-password'),
      body: jsonEncode({
        'email': email
      }),
      headers: {
        HttpHeaders.contentTypeHeader: ContentType.json.toString(),
      }
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao recuperar e-mail: ${response.statusCode}');
    }
  }

  Future<void> register(UserCreationDTO dto) async {
    final url = Uri.parse('$_apiUrl/api/v1/auth/register');
    final request = http.MultipartRequest('POST', url);

    dto.fillMultipartRequest(request);

    final response = await request.send();

    if (response.statusCode == 200) {
      _logger.i('Usuário registrado com sucesso!');
      return;
    }

    final responseBody = jsonDecode(await response.stream.bytesToString());

    final httpErrorDto = HttpErrorDTO.fromJson(responseBody);

    throw AuthException('Erro ao registrar usuário: ${httpErrorDto.message}');
  }

  Future<void> saveAuthData(AuthData authData) async {
    final json = authData.toJson();
    await _secureStorage.write(
        key: _authDataKey,
        value: jsonEncode(json)
    );
  }

  Future<AuthData?> getAuthData() async {
    final jsonString = await _secureStorage.read(key: _authDataKey);
    if (jsonString == null) return null;

    final json = jsonDecode(jsonString);
    return AuthData.fromJson(json);
  }

  Future<void> clearAuthData() async {
    await _secureStorage.delete(key: _authDataKey);
  }

}