// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_meeting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewMeeting _$NewMeetingFromJson(Map<String, dynamic> json) => NewMeeting(
  clubId: json['clubId'] as String,
  bookId: json['bookId'] as String,
  location: json['location'] as String,
  participantsIds:
      (json['participantsIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
  date: DateTime.parse(json['date'] as String),
);

Map<String, dynamic> _$NewMeetingToJson(NewMeeting instance) =>
    <String, dynamic>{
      'clubId': instance.clubId,
      'bookId': instance.bookId,
      'location': instance.location,
      'participantsIds': instance.participantsIds,
      'date': instance.date.toIso8601String(),
    };
