import 'package:booklub/domain/activities/activity.dart';
import 'package:booklub/domain/activities/user_activities/user_activity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_completed_reading_activity.g.dart';

@JsonSerializable()
class UserCompletedReadingActivity extends UserActivity {

  final String bookId;

  UserCompletedReadingActivity({
    required super.id,
    required super.createdAt,
    required super.type,
    required super.userId,
    required this.bookId,
  });

  factory UserCompletedReadingActivity.fromJson(Map<String, dynamic> json) =>
      _$UserCompletedReadingActivityFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserCompletedReadingActivityToJson(this);
}
