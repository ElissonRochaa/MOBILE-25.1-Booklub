import 'package:booklub/domain/entities/clubs/club.dart';
import 'package:booklub/utils/pagination/page.dart';
import 'package:booklub/utils/pagination/paginator.dart';

class ClubRepository {

  Club _dummy({
    String userId = '1',
    String ownerId = '1',
  }) => Club(
    id: userId,
    name: 'Civil War',
    creationTime: DateTime(2025, 4, 25),
    imageUrl: 'https://pt.quizur.com/_image?href=https://static.quizur.com/i/b/573e6c06640578.83502531573e6c06471173.49992186.png&w=1024&h=1024&f=webp',
    isPrivate: false,
    ownerId: ownerId
  );

  Page<Club> _dummyPage({
    required int page,
    required int pageSize,
    String userId = '1',
    String ownerId = '1',
  }) {
    return Page(
      content: List.generate(pageSize, (index) => _dummy(
        userId: userId,
        ownerId: ownerId
      )),
      pageInfo: PageInfo(
        size: pageSize,
        number: page,
        totalElements: pageSize * 4,
        totalPages: 4
      ),
    );
  }

  Future<Paginator<Club>> findClubs(int pageSize) async {
    Future.delayed(const Duration(seconds: 1));

    return Paginator.create(pageSize, (page, pageSize) async {
      await Future.delayed(const Duration(seconds: 1));
      return _dummyPage(
        page: page,
        pageSize: pageSize,
      );
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

}