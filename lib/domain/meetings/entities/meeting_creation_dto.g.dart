// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_creation_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeetingCreationDto _$MeetingCreationDtoFromJson(Map<String, dynamic> json) =>
    MeetingCreationDto(
      address: json['address'] as String,
      date: DateTime.parse(json['date'] as String),
      bookId: json['bookId'] as String,
      latlng: LatLng.fromJson(json['latlng'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MeetingCreationDtoToJson(MeetingCreationDto instance) =>
    <String, dynamic>{
      'address': instance.address,
      'date': instance.date.toIso8601String(),
      'bookId': instance.bookId,
      'latlng': instance.latlng,
    };
