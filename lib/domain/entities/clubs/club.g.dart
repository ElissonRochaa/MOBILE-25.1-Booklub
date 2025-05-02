// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Club _$ClubFromJson(Map<String, dynamic> json) => Club(
  id: json['id'] as String,
  name: json['name'] as String,
  creationTime: DateTime.parse(json['creationTime'] as String),
  imageUrl: json['imageUrl'] as String,
  isPrivate: json['isPrivate'] as bool,
  ownerId: json['ownerId'] as String,
);

Map<String, dynamic> _$ClubToJson(Club instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'creationTime': instance.creationTime.toIso8601String(),
  'imageUrl': instance.imageUrl,
  'isPrivate': instance.isPrivate,
  'ownerId': instance.ownerId,
};
