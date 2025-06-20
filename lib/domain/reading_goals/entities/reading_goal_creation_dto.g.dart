// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_goal_creation_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateReadingGoalDto _$CreateReadingGoalDtoFromJson(
  Map<String, dynamic> json,
) => CreateReadingGoalDto(
  bookId: json['bookId'] as String,
  startDate: json['startDate'] as String,
  endDate: json['endDate'] as String,
);

Map<String, dynamic> _$CreateReadingGoalDtoToJson(
  CreateReadingGoalDto instance,
) => <String, dynamic>{
  'bookId': instance.bookId,
  'startDate': instance.startDate,
  'endDate': instance.endDate,
};
