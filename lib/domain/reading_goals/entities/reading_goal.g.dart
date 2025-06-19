// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReadingGoal _$ReadingGoalFromJson(Map<String, dynamic> json) => ReadingGoal(
  id: json['id'] as String,
  bookId: json['bookId'] as String,
  clubId: json['clubId'] as String,
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: DateTime.parse(json['endDate'] as String),
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$ReadingGoalToJson(ReadingGoal instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bookId': instance.bookId,
      'clubId': instance.clubId,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
    };
