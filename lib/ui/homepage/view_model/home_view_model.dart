import 'package:booklub/infra/clubs/club_repository.dart';
import 'package:booklub/infra/auth/auth_repository.dart';
import 'package:booklub/domain/entities/clubs/club.dart';
import 'package:flutter/cupertino.dart';

class HomeViewModel extends ChangeNotifier {
  final ClubRepository clubRepository;
  final AuthRepository authRepository;

  List<Club> myClubs = [];
  bool isLoading = true;
  String? error;

  HomeViewModel({required this.clubRepository, required this.authRepository}) {
    _fetchMyClubs();
  }

  Future<void> _fetchMyClubs() async {
    try {
      isLoading = true;
      notifyListeners();

      final authData = await authRepository.getAuthData();
      final userId = authData?.user.id;

      if (userId == null) {
        throw Exception('Usuário não autenticado');
      }

      final paginator = await clubRepository.findClubsByUserId(5, userId);
      final firstPage = await paginator[0];
      myClubs = firstPage.content;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
