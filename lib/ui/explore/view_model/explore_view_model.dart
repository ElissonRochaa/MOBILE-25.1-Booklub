import 'package:booklub/domain/entities/clubs/club.dart';
import 'package:booklub/domain/entities/users/user.dart';
import 'package:booklub/infra/clubs/club_repository.dart';
import 'package:booklub/infra/user/user_repository.dart';
import 'package:booklub/utils/pagination/paginator.dart';
import 'package:flutter/cupertino.dart';

class ExploreViewModel extends ChangeNotifier {

  final UserRepository userRepository;

  ExploreViewModel({
    required this.userRepository,
  });

  Future<Paginator<User>> findByUsernameContaining(String username, int pageSize) async {
    return userRepository.findByUsernameContaining(username, pageSize);
  }
  Future<Paginator<User>> findBooksByTitleContaining(String username, int pageSize) async {
    return userRepository.findByUsernameContaining(username, pageSize);
  }
  Future<Paginator<User>> findClubByTitleContaining(String username, int pageSize) async {
    return userRepository.findByUsernameContaining(username, pageSize);
  }
  Future<Paginator<User>> findAllWithNameContaining(String username, int pageSize) async {
    return userRepository.findByUsernameContaining(username, pageSize);
  }
}