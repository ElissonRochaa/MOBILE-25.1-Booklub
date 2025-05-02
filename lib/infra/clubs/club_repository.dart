import 'package:booklub/domain/entities/clubs/club.dart';

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

  Future<List<Club>> findClubs() async {
    Future.delayed(const Duration(seconds: 1));
    return List.generate(10, (index) => _dummy());
  }

  Future<Club> findClubById(String clubId) async {
    Future.delayed(const Duration(seconds: 5));
    return _dummy();
  }

  Future<List<Club>> findClubsByUserId(String userId) async {
    Future.delayed(const Duration(seconds: 5));
    return List.generate(10, (index) => _dummy(userId: userId));
  }

}