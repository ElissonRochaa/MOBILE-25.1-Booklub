abstract final class Routes {

  static const String clubs = '/clubs';

  static const String profile = '/profile';

  static const String user = '/user';

  static String clubProfile({String? clubId = ':id'}) => '$clubs/$clubId';

  static String userProfile({String? userId = ':id'}) => '$user/$userId';

  static const String login = '/login';

  static const String register = '/register';
}