import 'dart:convert';
import 'dart:io';

import 'package:booklub/domain/entities/clubs/club.dart';
import 'package:booklub/domain/entities/clubs/club_creation_dto.dart';
import 'package:booklub/domain/entities/users/auth_data.dart';
import 'package:booklub/domain/entities/users/auth_token.dart';
import 'package:booklub/domain/entities/users/user.dart';
import 'package:booklub/infra/auth/auth_repository.dart';
import 'package:booklub/utils/http/http_error_dto.dart';
import 'package:booklub/utils/pagination/page.dart';
import 'package:booklub/utils/pagination/paginator.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class CreateClubException implements Exception {

  final String message;

  CreateClubException(this.message);

  @override
  String toString() => 'CreateClubException: $message';

}

class ClubRepository {

  final _logger = Logger();

  final String _apiUrl;

  final AuthRepository authRepository;

  ClubRepository({required String apiUrl, required this.authRepository})
    : _apiUrl = apiUrl;

  Future<AuthData> get _authData async {
    final authData = await authRepository.getAuthData();

    if (authData == null) {
      throw Exception('O usuário não está autenticado');
    }

    return authData;
  }

  Future<AuthToken> get _authToken async => (await _authData).token;

  Future<void> createClub(ClubCreationDTO club) async {
    final authData = await authRepository.getAuthData();

    if (authData == null) {
      throw Exception('O usuário não está autenticado');
    }

    final accessToken = authData.token.accessToken;

    final url = Uri.parse('$_apiUrl/api/v1/clubs');
    final request = http.MultipartRequest('POST', url);
    request.headers['Authorization'] = 'Bearer $accessToken';

    club.fillMultipartRequest(request);

    final response = await request.send();

    if (response.statusCode != 200) {
      final responseBody = jsonDecode(await response.stream.bytesToString());

      final httpErrorDto = HttpErrorDTO.fromJson(responseBody);

      throw CreateClubException(
        'Erro ao registrar usuário: ${httpErrorDto.message}',
      );
    }

    _logger.i('Club registrado com sucesso!');
  }

  Future<Paginator<Club>> findClubs(int pageSize) async {
    final authToken = await _authToken;

    return Paginator.create(pageSize, (page, size) async {
      final uri = Uri.parse(
        '$_apiUrl/api/v1/clubs',
      ).replace(
          queryParameters: {
            'page': page,
            'size': size,
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
        throw Exception('Erro ao buscar clubs');
      }

      return Page<Club>.fromJson(
        jsonDecode(response.body),
        (json) => Club.fromJson(json as Map<String, dynamic>),
      );
    });
  }

  Future<Club> findClubById(String clubId) async {
    final authToken = await _authToken;

    final uri = Uri.parse('$_apiUrl/api/v1/clubs/$clubId');

    final response = await http.get(
      uri,
      headers: {
        HttpHeaders.contentTypeHeader: ContentType.json.toString(),
        HttpHeaders.authorizationHeader: authToken.toString(),
      }
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao buscar club com ID $clubId');
    }

    return Club.fromJson(jsonDecode(response.body));
  }

  Future<Paginator<Club>> findClubsByUserId(int pageSize, String userId) async {
    final authToken = await _authToken;

    return Paginator.create(pageSize, (page, size) async {
      final uri = Uri.parse(
          '$_apiUrl/api/v1/users/$userId/clubs/participating'
      ).replace(
        queryParameters: {
          'page': page.toString(),
          'size': size.toString(),
        }
      );

      final response = await http.get(
        uri,
        headers: {
          HttpHeaders.contentTypeHeader: ContentType.json.toString(),
          HttpHeaders.authorizationHeader: authToken.toString(),
        }
      );

      if (response.statusCode != 200) {
        throw Exception('Erro ao buscar clubs do usuário com ID $userId');
      }

      final result = Page<Club>.fromJson(
        jsonDecode(response.body),
        (json) => Club.fromJson(json as Map<String, dynamic>),
      );

      return result;
    });
  }

  Future<Paginator<Club>> findClubsByOwnerId(int pageSize, String ownerId) async {
    final authToken = await _authToken;

    return Paginator.create(pageSize, (page, size) async {
      final uri = Uri.parse(
          '$_apiUrl/api/v1/users/$ownerId/clubs/owned'
      ).replace(
          queryParameters: {
            'page': page.toString(),
            'size': size.toString(),
          }
      );

      final response = await http.get(
          uri,
          headers: {
            HttpHeaders.contentTypeHeader: ContentType.json.toString(),
            HttpHeaders.authorizationHeader: authToken.toString(),
          }
      );

      if (response.statusCode != 200) {
        throw Exception('Erro ao buscar clubs com dono com ID $ownerId');
      }

      final result = Page<Club>.fromJson(
        jsonDecode(response.body),
            (json) => Club.fromJson(json as Map<String, dynamic>),
      );

      return result;
    });
  }

  Future<Paginator<Club>> searchClubByName(String name, int pageSize) async {
    final authToken = await _authToken;

    return Paginator.create(pageSize, (page, size) async {
      final uri = Uri.parse(
        '$_apiUrl/api/v1/clubs',
      ).replace(
          queryParameters: {
            'name': name,
            'page': page.toString(),
            'size': size.toString(),
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
        throw Exception('Erro ao buscar clubs com nome $name');
      }

      return Page<Club>.fromJson(
        jsonDecode(response.body),
            (json) => Club.fromJson(json as Map<String, dynamic>),
      );
    });
  }

  Future<Paginator<User>> findClubMembers(int pageSize, String clubId) async {
    final authToken = await _authToken;

    return Paginator.create(pageSize, (page, size) async {
      final uri = Uri.parse(
        '$_apiUrl/api/v1/clubs/$clubId/members'
      ).replace(
        queryParameters: {
          'page': page.toString(),
          'size': size.toString(),
        }
      );

      final response = await http.get(
        uri,
        headers: {
          HttpHeaders.contentTypeHeader: ContentType.json.toString(),
          HttpHeaders.authorizationHeader: authToken.toString(),
        }
      );

      if (response.statusCode != 200) {
        throw Exception('Erro ao buscar membros do clube com ID $clubId');
      }

      return Page<User>.fromJson(
        jsonDecode(response.body),
        (json) => User.fromJson(json as Map<String, dynamic>),
      );
    });
  }

}
