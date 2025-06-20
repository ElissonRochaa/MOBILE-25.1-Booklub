// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_pending_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClubPendingEntry _$ClubPendingEntryFromJson(Map<String, dynamic> json) =>
    ClubPendingEntry(
      userId: json['userId'] as String,
      clubId: json['clubId'] as String,
      entryType: $enumDecode(_$ClubPendingEntryTypeEnumMap, json['entryType']),
    );

Map<String, dynamic> _$ClubPendingEntryToJson(ClubPendingEntry instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'clubId': instance.clubId,
      'entryType': _$ClubPendingEntryTypeEnumMap[instance.entryType]!,
    };

const _$ClubPendingEntryTypeEnumMap = {
  ClubPendingEntryType.invitation: 'INVITATION',
  ClubPendingEntryType.request: 'REQUEST',
};
