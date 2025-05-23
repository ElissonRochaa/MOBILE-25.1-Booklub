import 'dart:convert';
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

  final logger = Logger();

  final apiUrl = 'http://10.0.2.2:8081';

  Future<AuthData> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$apiUrl/api/v1/auth/login'),
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return AuthData.fromJson(json);
    } else {
      throw Exception('Falha ao fazer login: ${response.statusCode}');
    }
  }

  Future<void> register(UserCreationDTO dto) async {
    final url = Uri.parse('$apiUrl/api/v1/auth/register');
    final request = http.MultipartRequest('POST', url);

    dto.fillMultipartRequest(request);

    final response = await request.send();

    if (response.statusCode == 200) {
      logger.i('Usuário registrado com sucesso!');
      return;
    }

    final responseBody = jsonDecode(await response.stream.bytesToString());

    final httpErrorDto = HttpErrorDTO.fromJson(responseBody);

    throw AuthException('Erro ao registrar usuário: ${httpErrorDto.message}');
  }

}