import 'package:booklub/domain/entities/clubs/club.dart';
import 'package:booklub/domain/entities/users/auth_data.dart';
import 'package:booklub/domain/entities/users/user.dart';
import 'package:booklub/infra/auth/auth_repository.dart';
import 'package:booklub/infra/clubs/club_repository.dart';
import 'package:booklub/infra/user/user_repository.dart';
import 'package:booklub/utils/pagination/paginator.dart';
import 'package:booklub/utils/pagination/page.dart' as pagination;
import 'package:flutter/cupertino.dart';

class UserProfileViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  final AuthRepository authRepository;
  final ClubRepository clubRepository;

  UserProfileViewModel({
    required this.userRepository,
    required this.authRepository,
    required this.clubRepository,
  });

  Future<User> getUserData(String id) async {
    final authData = await authRepository.getAuthData();

    if (id == authData!.user.id) {
      return authData.user;
    }
    
    return userRepository.getUserById(id);
  }

  Future<Paginator<Club>> getUserClubs(int pageSize, String id) {
    return clubRepository.findClubsByUserId(pageSize, id);
  }
}
