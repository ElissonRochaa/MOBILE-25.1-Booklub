// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_defined_activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeetingDefinedActivity _$MeetingDefinedActivityFromJson(
  Map<String, dynamic> json,
) => MeetingDefinedActivity(
  id: json['id'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  type: $enumDecode(_$ActivityTypeEnumMap, json['type']),
  clubId: json['clubId'] as String,
  meetingId: json['meetingId'] as String,
);

Map<String, dynamic> _$MeetingDefinedActivityToJson(
  MeetingDefinedActivity instance,
) => <String, dynamic>{
  'id': instance.id,
  'createdAt': instance.createdAt.toIso8601String(),
  'type': _$ActivityTypeEnumMap[instance.type]!,
  'clubId': instance.clubId,
  'meetingId': instance.meetingId,
};

const _$ActivityTypeEnumMap = {
  ActivityType.meetingDefined: 'MEETING_DEFINED',
  ActivityType.memberCompletedReading: 'MEMBER_COMPLETED_READING',
  ActivityType.readingGoalDefined: 'READING_GOAL_DEFINED',
  ActivityType.userCompletedReading: 'USER_COMPLETED_READING',
};
