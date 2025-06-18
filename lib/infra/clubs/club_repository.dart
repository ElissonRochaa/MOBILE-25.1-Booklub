import 'dart:convert';
import 'dart:io';

import 'package:booklub/domain/entities/clubs/club.dart';
import 'package:booklub/domain/entities/clubs/club_creation_dto.dart';
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

  Club _dummy({String userId = '1', String ownerId = '1'}) => Club(
    id: userId,
    name: 'Civil War',
    creationDate: DateTime(2025, 4, 25),
    imageUrl:
        'https://pt.quizur.com/_image?href=https://static.quizur.com/i/b/573e6c06640578.83502531573e6c06471173.49992186.png&w=1024&h=1024&f=webp',
    isPrivate: false,
    ownerId: ownerId,
  );

  Page<Club> _dummyPage({
    required int page,
    required int pageSize,
    String userId = '1',
    String ownerId = '1',
  }) {
    return Page(
      content: List.generate(
        pageSize,
        (index) => _dummy(userId: userId, ownerId: ownerId),
      ),
      pageInfo: PageInfo(
        size: pageSize,
        number: page,
        totalElements: pageSize * 4,
        totalPages: 4,
      ),
    );
  }

  Future<Paginator<Club>> findClubs(int pageSize) async {
    Future.delayed(const Duration(seconds: 1));

    return Paginator.create(pageSize, (page, pageSize) async {
      await Future.delayed(const Duration(seconds: 1));
      return _dummyPage(page: page, pageSize: pageSize);
    });
  }

  Future<Club> findClubById(String clubId) async {
    Future.delayed(const Duration(seconds: 5));
    return _dummy();
  }

  Future<Paginator<Club>> findClubsByUserId(int pageSize, String userId) async {
    Future.delayed(const Duration(seconds: 5));
    return Paginator.create(pageSize, (page, pageSize) async {
      await Future.delayed(const Duration(seconds: 1));
      return _dummyPage(
        page: page,
        pageSize: pageSize,
        userId: userId,
        ownerId: userId,
      );
    });
  }

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

  Future<Paginator<Club>> searchClubByName(String name, int pageSize) async {
    print(name);
    final authData = await authRepository.getAuthData();

    if (authData == null) {
      throw Exception('O usuário não está autenticado');
    }

    final accessToken = authData.token.accessToken;

    return Paginator.create(pageSize, (pageIdx, pageSize) async {
      final response = await http.get(
        Uri.parse(
          '$_apiUrl/api/v1/clubs',
        ).replace(queryParameters: {'name': name}),
        headers: {
          HttpHeaders.contentTypeHeader: ContentType.json.toString(),
          HttpHeaders.authorizationHeader: 'Bearer $accessToken',
        },
      );

      final json = jsonDecode(response.body);
      final page = Page<Club>.fromJson(
        json,
        (json) => Club.fromJson(json as Map<String, dynamic>),
      );
      return page;
    });
  }
}
