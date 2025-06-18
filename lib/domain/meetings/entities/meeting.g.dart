// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Meeting _$MeetingFromJson(Map<String, dynamic> json) => Meeting(
  id: json['id'] as String,
  readingGoalId: json['readingGoalId'] as String,
  clubId: json['clubId'] as String,
  address: json['address'] as String,
  latlng: LatLng.fromJson(json['latlng'] as Map<String, dynamic>),
  date: DateTime.parse(json['date'] as String),
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$MeetingToJson(Meeting instance) => <String, dynamic>{
  'id': instance.id,
  'readingGoalId': instance.readingGoalId,
  'clubId': instance.clubId,
  'address': instance.address,
  'latlng': instance.latlng,
  'date': instance.date.toIso8601String(),
  'createdAt': instance.createdAt.toIso8601String(),
};
