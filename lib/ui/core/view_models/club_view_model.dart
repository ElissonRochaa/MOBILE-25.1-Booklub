import 'package:booklub/domain/entities/clubs/club.dart';
import 'package:booklub/infra/clubs/club_repository.dart';

class ClubViewModel {
  // ignore: unused_field
  final ClubRepository _repository;

  const ClubViewModel({
    required ClubRepository repository,
  }) : _repository = repository;

  Future<Club?> getClub(String id) async {
    return _repository.findClubById(id);
  }
}