import 'package:json_annotation/json_annotation.dart';

part 'club_pending_entry.g.dart';

enum ClubPendingEntryType {

  @JsonValue("INVITATION")
  invitation,

  @JsonValue("REQUEST")
  request,

}

@JsonSerializable()
class ClubPendingEntry {

  final String userId;

  final String clubId;

  final ClubPendingEntryType entryType;

  const ClubPendingEntry({
    required this.userId,
    required this.clubId,
    required this.entryType,
  });

  factory ClubPendingEntry.fromJson(Map<String, dynamic> json) =>
      _$ClubPendingEntryFromJson(json);

  Map<String, dynamic> toJson() => _$ClubPendingEntryToJson(this);


}