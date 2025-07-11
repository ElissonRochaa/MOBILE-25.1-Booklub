import 'package:booklub/domain/entities/users/auth_data.dart';
import 'package:booklub/domain/entities/users/auth_token.dart';
import 'package:booklub/infra/auth/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

class AuthViewModel extends ChangeNotifier {

  final logger = Logger();

  final AuthRepository _authRepository;

  bool _isValidating = false;

  AuthToken? _authToken;

  AuthToken? get authToken => _authToken;

  String get fullAccessToken => '$_authToken.tokenType $_authToken.accessToken';

  Future<AuthData?> get authData async => await _authRepository.getAuthData();

  AuthViewModel({
    required AuthRepository authRepository
  }) : _authRepository = authRepository {
    _authRepository.getAuthData().then(
      (authData) => _setAuthToken(authData?.token, notify: false)
    );
  }

  void _setAuthToken(AuthToken? authToken, {bool notify = false}) {
    _authToken = authToken;
    if (notify) notifyListeners();
  }

  Future<bool> validateToken() async {
    if (_isValidating) return false;
    _isValidating = true;

    if (_authToken == null) {
      await _refresh();
      if (_authToken == null) {
        logger.d('Usuário não autenticado');
        _isValidating = false;
        return false;
      }
    }

    print('Validando token: ${_authToken!.expiration}');

    if (_authToken!.expiration.isAfter(DateTime.now())) {
      logger.d('Token validado com sucesso.');
      _isValidating = false;
      return true;
    }

    _authToken = null;
    logger.d('Token expirado.');
    _isValidating = false;
    return false;
  }

  Future<void> _refresh() async {
    final authData = await _authRepository.getAuthData();
    _setAuthToken(authData?.token, notify: false);
  }

  Future<void> logout() async {
    _authRepository.clearAuthData();
    _setAuthToken(null, notify: true);
  }

  Future<AuthData> getAuthData() async {
    final authData = await _authRepository.getAuthData();

    return authData!;
  }


}
