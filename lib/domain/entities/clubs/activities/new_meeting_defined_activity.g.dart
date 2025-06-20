// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_meeting_defined_activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewMeetingDefinedActivity _$NewMeetingDefinedActivityFromJson(
  Map<String, dynamic> json,
) => NewMeetingDefinedActivity(
  clubId: json['clubId'] as String,
  bookId: json['bookId'] as String,
  location: json['location'] as String,
  participantsIds:
      (json['participantsIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
  date: DateTime.parse(json['date'] as String),
);

Map<String, dynamic> _$NewMeetingDefinedActivityToJson(
  NewMeetingDefinedActivity instance,
) => <String, dynamic>{
  'clubId': instance.clubId,
  'bookId': instance.bookId,
  'location': instance.location,
  'participantsIds': instance.participantsIds,
  'date': instance.date.toIso8601String(),
};
