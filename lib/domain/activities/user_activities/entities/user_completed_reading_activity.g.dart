// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_completed_reading_activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCompletedReadingActivity _$UserCompletedReadingActivityFromJson(
  Map<String, dynamic> json,
) => UserCompletedReadingActivity(
  id: json['id'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  type: $enumDecode(_$ActivityTypeEnumMap, json['type']),
  userId: json['userId'] as String,
  bookId: json['bookId'] as String,
);

Map<String, dynamic> _$UserCompletedReadingActivityToJson(
  UserCompletedReadingActivity instance,
) => <String, dynamic>{
  'id': instance.id,
  'createdAt': instance.createdAt.toIso8601String(),
  'type': _$ActivityTypeEnumMap[instance.type]!,
  'userId': instance.userId,
  'bookId': instance.bookId,
};

const _$ActivityTypeEnumMap = {
  ActivityType.meetingDefined: 'MEETING_DEFINED',
  ActivityType.memberCompletedReading: 'MEMBER_COMPLETED_READING',
  ActivityType.readingGoalDefined: 'READING_GOAL_DEFINED',
  ActivityType.userCompletedReading: 'USER_COMPLETED_READING',
};
