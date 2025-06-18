import 'package:booklub/domain/entities/clubs/club.dart';
import 'package:booklub/infra/clubs/club_repository.dart';
import 'package:booklub/utils/pagination/paginator.dart';
import 'package:flutter/cupertino.dart';

class ClubsViewModel extends ChangeNotifier {

  final ClubRepository clubRepository;

  ClubsViewModel({
    required this.clubRepository,
  });

  Future<Paginator<Club>> findMyClubs(int pageSize) async {
    return clubRepository.findClubsByUserId(pageSize, '1');
  }

  Future<Paginator<Club>> findManagedClubs(int pageSize) async {
    return clubRepository.findClubsByUserId(pageSize, '1');
  }

  Future<Paginator<Club>> findRecentClubs(int pageSize) async {
    return clubRepository.findClubsByUserId(pageSize, '1');
  }

  Future<Paginator<Club>> findAllClubs(int pageSize) async {
    return clubRepository.findClubs(pageSize);
  }


}