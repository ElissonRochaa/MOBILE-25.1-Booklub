import 'package:booklub/domain/activities/entities/activity.dart';

abstract class ClubActivity extends Activity {

  final String clubId;

  ClubActivity({
    required super.id,
    required super.createdAt,
    required super.type,
    required this.clubId,
  });



}