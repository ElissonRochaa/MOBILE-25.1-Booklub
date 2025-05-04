import 'package:booklub/domain/entities/clubs/club.dart';
import 'package:booklub/infra/clubs/club_repository.dart';
import 'package:flutter/cupertino.dart';

class ClubProfileViewModel extends ChangeNotifier {

  final ClubRepository _clubRepository;

  ClubProfileViewModel({
    required ClubRepository clubRepository
  }): _clubRepository = clubRepository;

  Future<Club> findClubById(String clubId) async {
    return _clubRepository.findClubById(clubId);
  }

}