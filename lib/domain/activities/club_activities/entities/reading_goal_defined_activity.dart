import 'package:booklub/domain/activities/entities/activity.dart';
import 'package:json_annotation/json_annotation.dart';

import 'club_activity.dart' show ClubActivity;

part 'reading_goal_defined_activity.g.dart';

@JsonSerializable()
class ReadingGoalDefinedActivity extends ClubActivity {

  final String readingGoalId;

  ReadingGoalDefinedActivity({
    required super.id,
    required super.createdAt,
    required super.type,
    required super.clubId,
    required this.readingGoalId,
  });

  factory ReadingGoalDefinedActivity.fromJson(Map<String, dynamic> json) =>
      _$ReadingGoalDefinedActivityFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ReadingGoalDefinedActivityToJson(this);
}