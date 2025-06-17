// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_reading_goal_defined_activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewReadingGoalDefinedActivity _$NewReadingGoalDefinedActivityFromJson(
  Map<String, dynamic> json,
) => NewReadingGoalDefinedActivity(
  clubId: json['clubId'] as String,
  bookId: json['bookId'] as String,
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: DateTime.parse(json['endDate'] as String),
);

Map<String, dynamic> _$NewReadingGoalDefinedActivityToJson(
  NewReadingGoalDefinedActivity instance,
) => <String, dynamic>{
  'clubId': instance.clubId,
  'bookId': instance.bookId,
  'startDate': instance.startDate.toIso8601String(),
  'endDate': instance.endDate.toIso8601String(),
};
