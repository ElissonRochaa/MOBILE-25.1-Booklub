abstract final class Routes {

  static const String clubs = '/clubs';

  static const String profile = '/profile';

  static String clubProfile({String? clubId = ':id'}) => '$clubs/$clubId';

  static const String login = '/login';

  static const String register = '/register';

  static const String createClub = '/create-club';
}