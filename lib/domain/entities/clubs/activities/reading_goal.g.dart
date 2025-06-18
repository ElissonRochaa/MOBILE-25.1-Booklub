// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReadingGoal _$ReadingGoalFromJson(Map<String, dynamic> json) => ReadingGoal(
  clubId: json['clubId'] as String,
  bookId: json['bookId'] as String,
  startDate: DateTime.parse(json['startDate'] as String),
  finishDate: DateTime.parse(json['finishDate'] as String),
);

Map<String, dynamic> _$ReadingGoalToJson(ReadingGoal instance) =>
    <String, dynamic>{
      'clubId': instance.clubId,
      'bookId': instance.bookId,
      'startDate': instance.startDate.toIso8601String(),
      'finishDate': instance.finishDate.toIso8601String(),
    };
