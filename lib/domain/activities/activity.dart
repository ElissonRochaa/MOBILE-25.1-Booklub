import 'package:booklub/domain/activities/club_activities/meeting_defined_activity.dart';
import 'package:booklub/domain/activities/club_activities/member_completed_reading_activity.dart';
import 'package:booklub/domain/activities/club_activities/reading_goal_defined_activity.dart';
import 'package:json_annotation/json_annotation.dart';

import 'user_activities/user_completed_reading_activity.dart';

part 'activity.g.dart';

@JsonEnum(alwaysCreate: true)
enum ActivityType {
  
  @JsonValue('MEETING_DEFINED')
  meetingDefined,

  @JsonValue('MEMBER_COMPLETED_READING')
  memberCompletedReading,

  @JsonValue('READING_GOAL_DEFINED')
  readingGoalDefined,

  @JsonValue('USER_COMPLETED_READING')
  userCompletedReading,
  
}

abstract class Activity {

  final String id;

  final DateTime createdAt;

  final ActivityType type;

  Activity({
    required this.id,
    required this.createdAt,
    required this.type,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    final typeString = json['type'] as String?;

    if (typeString == null) {
      throw Exception('Could not deserialize Activity: missing "type" field');
    }

    final type = $enumDecode(_$ActivityTypeEnumMap, typeString);

    switch (type) {
      case ActivityType.meetingDefined:
        return MeetingDefinedActivity.fromJson(json);
      case ActivityType.memberCompletedReading:
        return MemberCompletedReadingActivity.fromJson(json);
      case ActivityType.readingGoalDefined:
        return ReadingGoalDefinedActivity.fromJson(json);
      case ActivityType.userCompletedReading:
        return UserCompletedReadingActivity.fromJson(json);
    }
  }

  Map<String, dynamic> toJson();

}

