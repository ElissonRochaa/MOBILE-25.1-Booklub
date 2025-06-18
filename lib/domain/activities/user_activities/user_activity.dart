import 'package:booklub/domain/activities/activity.dart';

abstract class UserActivity extends Activity {

  final String userId;

  UserActivity({
    required super.id,
    required super.createdAt,
    required super.type,
    required this.userId,
  });

}