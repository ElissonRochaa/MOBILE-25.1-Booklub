import 'package:booklub/domain/entities/books/book_item.dart';
import 'package:booklub/domain/entities/clubs/club.dart';
import 'package:booklub/domain/entities/users/user.dart';
import 'package:booklub/infra/books/book_api_repository.dart';
import 'package:booklub/infra/clubs/club_repository.dart';
import 'package:booklub/infra/user/user_repository.dart';
import 'package:booklub/utils/pagination/paginator.dart';
import 'package:booklub/utils/pagination/page.dart' as pagination;
import 'package:flutter/cupertino.dart';

class ExploreViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  final ClubRepository clubRepository;
  final BookApiRepository bookApiRepository;

  ExploreViewModel({
    required this.userRepository,
    required this.clubRepository,
    required this.bookApiRepository,
  });

  Future<Paginator<User>> findByUsernameContaining(
    String username,
    int pageSize,
  ) async {
    return userRepository.findByUsernameContaining(username, pageSize);
  }

  Future<Paginator<BookItem>> findBooksByTitleContaining(
    String title,
    int pageSize,
  ) async {
    return bookApiRepository.searchBooks(intitle: title, page: pageSize);
  }

  Future<Paginator<Club>> searchClubByName(String name, int pageSize) async {
    return clubRepository.searchClubByName(name, pageSize);
  }

  Future<Paginator<Object>> findAllWithNameContaining(
    String query,
    int pageSize,
  ) async {
    final individualPageSize = (pageSize / 3).ceil();

    final usersFuture = userRepository.findByUsernameContaining(
      query,
      individualPageSize,
    );
    final clubsFuture = clubRepository.searchClubByName(
      query,
      individualPageSize,
    );
    final booksFuture = bookApiRepository.searchBooks(
      intitle: query,
      size: individualPageSize,
    );

    final results = await Future.wait([usersFuture, clubsFuture, booksFuture]);

    final userPage = await results[0][0];
    final clubPage = await results[1][0];
    final bookPage = await results[2][0];

    final combinedContent = <Object>[
      ...userPage.content,
      ...clubPage.content,
      ...bookPage.content,
    ];

    final totalElements =
        userPage.pageInfo.totalElements +
        clubPage.pageInfo.totalElements +
        bookPage.pageInfo.totalElements;

    final totalPages = 1;

    final combinedPage = pagination.Page<Object>(
      content: combinedContent,
      pageInfo: pagination.PageInfo(
        size: combinedContent.length,
        number: 0,
        totalElements: totalElements,
        totalPages: totalPages,
      ),
    );

    Future<pagination.Page<Object>> retriever(int page, int size) async =>
        combinedPage;

    return await Paginator.create<Object>(pageSize, retriever);
  }
}
