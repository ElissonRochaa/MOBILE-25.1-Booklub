import 'package:booklub/domain/entities/clubs/club.dart';
import 'package:booklub/infra/clubs/club_repository.dart';
import 'package:flutter/cupertino.dart';

class ClubsViewModel extends ChangeNotifier {

  final ClubRepository clubRepository;

  ClubsViewModel({
    required this.clubRepository,
  });

  Future<List<Club>> get myClubs async {
    return clubRepository.findClubsByUserId('1');
  }

  Future<List<Club>> get recentClubs async {
    return clubRepository.findClubsByUserId('1');
  }

  Future<List<Club>> get allClubs async {
    return clubRepository.findClubsByUserId('1');
  }


}