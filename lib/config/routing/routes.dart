abstract final class Routes {
  static const String home = '/';

  static const String clubs = '/clubs';

  static String edit({String? userId = ':id'}) =>
      '${userProfile(userId: userId)}/edit';

  static String clubProfile({String? clubId = ':id'}) => '$clubs/$clubId';

  static String userProfile({String? userId = ':id'}) => '/user/$userId';

  static const String login = '/login';

  static const String recoverPassword = '/recover-password';

  static const String checkYourEmailRecover = '/check-email-recover';

  static const String register = '/register';

  static const String book = '/book';

  static String individualBook({String bookId = ':id'}) => '$book/$bookId';

  static String explore = '/explore';

  static const String notifications = '/notifications';
  
  static const String createClub = '/create-club';

  static String createClubContent({String? clubId = ':id'}) => '/clubs/$clubId/create-content';

}
