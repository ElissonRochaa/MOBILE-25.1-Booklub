import 'dart:convert';
import 'dart:io';

import 'package:booklub/domain/activities/entities/activity.dart';
import 'package:booklub/infra/auth/auth_repository.dart';
import 'package:booklub/utils/pagination/page.dart';
import 'package:booklub/utils/pagination/paginator.dart';
import 'package:http/http.dart' as http;

class ActivitiesRepository {

  final AuthRepository _authRepository;

  final String _apiUrl;

  ActivitiesRepository({
    required AuthRepository authRepository,
    required String apiUrl,
  }): _authRepository = authRepository, _apiUrl = apiUrl;

  Future<Paginator<Activity>> findActivitiesByClubId(
    String clubId,
    int pageSize,
  ) async {
    final authToken = (await _authRepository.getAuthData())!.token;

    return Paginator.create(pageSize, (page, pageSize) async {
      final uri = Uri.parse(
        '$_apiUrl/api/v1/clubs/$clubId/activities',
      ).replace(
        queryParameters: {
          'page': page.toString(),
          'size': pageSize.toString(),
        },
      );

      final response = await http.get(
        uri,
        headers: {
          HttpHeaders.contentTypeHeader: ContentType.json.toString(),
          HttpHeaders.authorizationHeader: authToken.toString(),
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Erro ao buscar atividades do clube com ID $clubId');
      }

      return Page<Activity>.fromJson(
        jsonDecode(response.body),
        (json) => Activity.fromJson(json as Map<String, dynamic>),
      );
    });
  }


  Future<Paginator<Activity>> findActivitiesByUserId(
    String userId,
    int pageSize,
  ) async {
    final authToken = (await _authRepository.getAuthData())!.token;

    return Paginator.create(pageSize, (page, pageSize) async {
      final uri = Uri.parse(
        '$_apiUrl/api/v1/users/$userId/activities',
      ).replace(
        queryParameters: {
          'page': page.toString(),
          'size': pageSize.toString(),
        },
      );

      final response = await http.get(
        uri,
        headers: {
          HttpHeaders.contentTypeHeader: ContentType.json.toString(),
          HttpHeaders.authorizationHeader: authToken.toString(),
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Erro ao buscar atividades do usuário com ID $userId');
      }

      return Page<Activity>.fromJson(
        jsonDecode(response.body),
            (json) => Activity.fromJson(json as Map<String, dynamic>),
      );
    });
  }

Future<Paginator<Activity>> findActivitiesForUser(
    String userId,
    int pageSize,
  ) async {
    final authToken = (await _authRepository.getAuthData())!.token;

    return Paginator.create(pageSize, (page, pageSize) async {
      final uri = Uri.parse('$_apiUrl/api/v1/activities').replace(
        queryParameters: {
          'userId': userId,
          'page': page.toString(),
          'size': pageSize.toString(),
        },
      );

      final response = await http.get(
        uri,
        headers: {
          HttpHeaders.contentTypeHeader: ContentType.json.toString(),
          HttpHeaders.authorizationHeader: authToken.toString(),
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Erro ao buscar atividades do usuário $userId');
      }

      return Page<Activity>.fromJson(
        jsonDecode(response.body),
        (json) => Activity.fromJson(json as Map<String, dynamic>),
      );
    });
  }

}