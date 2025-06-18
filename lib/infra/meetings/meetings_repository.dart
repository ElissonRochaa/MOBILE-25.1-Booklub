import 'dart:convert';
import 'dart:io';

import 'package:booklub/domain/meetings/entities/meeting.dart';
import 'package:booklub/infra/auth/auth_repository.dart';
import 'package:booklub/utils/pagination/page.dart';
import 'package:booklub/utils/pagination/paginator.dart';
import 'package:http/http.dart' as http;

class MeetingsRepository {

  final AuthRepository _authRepository;

  final String _apiUrl;

  MeetingsRepository({
    required AuthRepository authRepository,
    required String apiUrl
  }): _authRepository = authRepository, _apiUrl = apiUrl;

  Future<Paginator<Meeting>> findMeetingsByClubId(
    String clubId,
    int pageSize,
  ) async {
    final authToken = (await _authRepository.getAuthData())!.token;

    return Paginator.create(pageSize, (page, pageSize) async {
      final uri = Uri.parse(
          '$_apiUrl/api/v1/clubs/$clubId/meetings'
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
        throw Exception('Erro ao buscar meetings do clube com ID $clubId');
      }

      return Page<Meeting>.fromJson(
        jsonDecode(response.body),
            (json) => Meeting.fromJson(json as Map<String, dynamic>),
      );
    });
  }

  Future<Meeting> findNextMeetingByClubId(String clubId) async {
    final authToken = (await _authRepository.getAuthData())!.token;

    final uri = Uri.parse('$_apiUrl/api/v1/clubs/$clubId/meetings/next');

    final response = await http.get(
      uri,
      headers: {
        HttpHeaders.contentTypeHeader: ContentType.json.toString(),
        HttpHeaders.authorizationHeader: authToken.toString(),
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao buscar o próximo meeting do clube com ID $clubId');
    }

    return Meeting.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }

  Future<Meeting> findMeetingByReadingGoalId(String readingGoalId) async {
    final authToken = (await _authRepository.getAuthData())!.token;

    final uri = Uri.parse('$_apiUrl/api/v1/reading-goals/$readingGoalId/meeting');

    final response = await http.get(
      uri,
      headers: {
        HttpHeaders.contentTypeHeader: ContentType.json.toString(),
        HttpHeaders.authorizationHeader: authToken.toString(),
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao buscar meeting do reading goal com ID $readingGoalId');
    }

    return Meeting.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }

  Future<Meeting> findMeetingById(String meetingId) async {
    final authToken = (await _authRepository.getAuthData())!.token;

    final uri = Uri.parse('$_apiUrl/api/v1/meetings/$meetingId');

    final response = await http.get(
      uri,
      headers: {
        HttpHeaders.contentTypeHeader: ContentType.json.toString(),
        HttpHeaders.authorizationHeader: authToken.toString(),
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao buscar meeting com ID $meetingId');
    }

    return Meeting.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }



}