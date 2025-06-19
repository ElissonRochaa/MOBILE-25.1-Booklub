// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_completed_reading_activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberCompletedReadingActivity _$MemberCompletedReadingActivityFromJson(
  Map<String, dynamic> json,
) => MemberCompletedReadingActivity(
  id: json['id'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  type: $enumDecode(_$ActivityTypeEnumMap, json['type']),
  clubId: json['clubId'] as String,
  userId: json['userId'] as String,
  bookId: json['bookId'] as String,
);

Map<String, dynamic> _$MemberCompletedReadingActivityToJson(
  MemberCompletedReadingActivity instance,
) => <String, dynamic>{
  'id': instance.id,
  'createdAt': instance.createdAt.toIso8601String(),
  'type': _$ActivityTypeEnumMap[instance.type]!,
  'clubId': instance.clubId,
  'userId': instance.userId,
  'bookId': instance.bookId,
};

const _$ActivityTypeEnumMap = {
  ActivityType.meetingDefined: 'MEETING_DEFINED',
  ActivityType.memberCompletedReading: 'MEMBER_COMPLETED_READING',
  ActivityType.readingGoalDefined: 'READING_GOAL_DEFINED',
  ActivityType.userCompletedReading: 'USER_COMPLETED_READING',
};
