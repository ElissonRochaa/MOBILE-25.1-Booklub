import 'package:booklub/domain/entities/clubs/club.dart';
import 'package:booklub/infra/clubs/club_repository.dart';
import 'package:booklub/ui/core/view_models/auth_view_model.dart';
import 'package:booklub/utils/pagination/paginator.dart';
import 'package:flutter/cupertino.dart';

class ClubsViewModel extends ChangeNotifier {

  final ClubRepository clubRepository;

  final AuthViewModel authViewModel;

  ClubsViewModel({
    required this.clubRepository,
    required this.authViewModel,
  });

  Future<String> get _loggedUserId async => (await authViewModel.authData)!.user.id;

  Future<Paginator<Club>> findMyClubs(int pageSize) async {
    return clubRepository.findClubsByUserId(pageSize, await _loggedUserId);
  }

  Future<Paginator<Club>> findManagedClubs(int pageSize) async {
    return clubRepository.findClubsByOwnerId(pageSize, await _loggedUserId);
  }

}