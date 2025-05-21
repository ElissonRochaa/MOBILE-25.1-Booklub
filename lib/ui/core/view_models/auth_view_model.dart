import 'package:booklub/domain/entities/users/auth_data.dart';
import 'package:booklub/domain/entities/users/user_creation_dto.dart';
import 'package:booklub/infra/auth/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

class AuthViewModel extends ChangeNotifier {

  final logger = Logger();

  final AuthRepository authRepository;

  AuthData? _authData;

  AuthData? get authData => _authData;

  String get fullAccessToken => '$_authData.token.tokenType $_authData.token.accessToken';

  bool get isAuthenticated {
    if (_authData == null) return false;
    validateToken();
    return _authData != null;
  }

  AuthViewModel({required this.authRepository});

  void _setAuthData(AuthData? authData) {
    _authData = authData;
    notifyListeners();
  }

  Future<void> validateToken() async {
    if (_authData == null) throw StateError('Usuário não autenticado');

    if (_authData!.token.expiration.isBefore(DateTime.now())) {
      logger.i('Token validado com sucesso.');
      return;
    }

    _setAuthData(null);
    logger.w('Token expirado.');
  }

  Future<void> login(String email, String password) async {
    _setAuthData(await authRepository.login(email, password));
  }

  Future<void> register(UserCreationDTO dto) async {
    authRepository.register(dto);
  }

  Future<void> logout() async {
    _setAuthData(null);
  }

}
