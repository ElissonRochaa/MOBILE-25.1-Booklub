// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_goal_defined_activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReadingGoalDefinedActivity _$ReadingGoalDefinedActivityFromJson(
  Map<String, dynamic> json,
) => ReadingGoalDefinedActivity(
  id: json['id'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  type: $enumDecode(_$ActivityTypeEnumMap, json['type']),
  clubId: json['clubId'] as String,
  readingGoalId: json['readingGoalId'] as String,
);

Map<String, dynamic> _$ReadingGoalDefinedActivityToJson(
  ReadingGoalDefinedActivity instance,
) => <String, dynamic>{
  'id': instance.id,
  'createdAt': instance.createdAt.toIso8601String(),
  'type': _$ActivityTypeEnumMap[instance.type]!,
  'clubId': instance.clubId,
  'readingGoalId': instance.readingGoalId,
};

const _$ActivityTypeEnumMap = {
  ActivityType.meetingDefined: 'MEETING_DEFINED',
  ActivityType.memberCompletedReading: 'MEMBER_COMPLETED_READING',
  ActivityType.readingGoalDefined: 'READING_GOAL_DEFINED',
  ActivityType.userCompletedReading: 'USER_COMPLETED_READING',
};
