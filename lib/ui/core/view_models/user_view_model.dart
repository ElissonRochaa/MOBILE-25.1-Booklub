import 'package:booklub/domain/entities/users/user.dart';
import 'package:booklub/infra/user/user_repository.dart';

class UserViewModel {
  final UserRepository _repository;

  const UserViewModel({
    required UserRepository repository,
  }) : _repository = repository;

  Future<User?> getUser(String id) async {
    return _repository.findById(id);
  }
}