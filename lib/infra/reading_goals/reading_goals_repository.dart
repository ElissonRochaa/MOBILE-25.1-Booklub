import 'dart:convert';
import 'dart:io';

import 'package:booklub/domain/reading_goals/entities/reading_goal.dart';
import 'package:booklub/infra/auth/auth_repository.dart';
import 'package:booklub/utils/pagination/page.dart';
import 'package:booklub/utils/pagination/paginator.dart';
import 'package:http/http.dart' as http;

class ReadingGoalsRepository {

  final AuthRepository _authRepository;

  final String _apiUrl;

  ReadingGoalsRepository({
    required AuthRepository authRepository,
    required String apiUrl
  }): _authRepository = authRepository, _apiUrl = apiUrl;

  Future<Paginator<ReadingGoal>> findReadingGoalsByClubId(
    String clubId,
    int pageSize,
  ) async {
    final authToken = (await _authRepository.getAuthData())!.token;

    return Paginator.create(pageSize, (page, pageSize) async {
      final uri = Uri.parse(
        '$_apiUrl/api/v1/clubs/$clubId/reading-goals'
      ).replace(
        queryParameters: {
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
        throw Exception('Erro ao buscar reading goals do clube com ID $clubId');
      }

      return Page<ReadingGoal>.fromJson(
        jsonDecode(response.body),
        (json) => ReadingGoal.fromJson(json as Map<String, dynamic>),
      );
    });
  }

  Future<ReadingGoal> findById(String readingGoalId) async {
    final authToken = (await _authRepository.getAuthData())!.token;

    final uri = Uri.parse('$_apiUrl/api/v1/reading-goals/$readingGoalId');

    final response = await http.get(
      uri,
      headers: {
        HttpHeaders.contentTypeHeader: ContentType.json.toString(),
        HttpHeaders.authorizationHeader: authToken.toString(),
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao buscar reading goal com ID $readingGoalId');
    }

    return ReadingGoal.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }


}