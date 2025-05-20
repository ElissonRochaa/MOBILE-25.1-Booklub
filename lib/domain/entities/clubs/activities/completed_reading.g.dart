// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'completed_reading.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompletedReading _$CompletedReadingFromJson(Map<String, dynamic> json) =>
    CompletedReading(
      clubId: json['clubId'] as String,
      bookId: json['bookId'] as String,
      userId: json['userId'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      finishDate: DateTime.parse(json['finishDate'] as String),
    );

Map<String, dynamic> _$CompletedReadingToJson(CompletedReading instance) =>
    <String, dynamic>{
      'clubId': instance.clubId,
      'bookId': instance.bookId,
      'userId': instance.userId,
      'startDate': instance.startDate.toIso8601String(),
      'finishDate': instance.finishDate.toIso8601String(),
    };
