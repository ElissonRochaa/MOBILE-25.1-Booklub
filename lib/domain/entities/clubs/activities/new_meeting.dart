import 'package:booklub/domain/entities/clubs/activities/club_activity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'new_meeting.g.dart';

@JsonSerializable()
class NewMeeting extends ClubActivity {

  final String bookId;

  final String location;

  final List<String> participantsIds;

  final DateTime date;

  NewMeeting({
    required super.clubId,
    required this.bookId,
    required this.location,
    required this.participantsIds,
    required this.date,
  });

  factory NewMeeting.fromJson(Map<String, dynamic> json) => _$NewMeetingFromJson(json);

  Map<String, dynamic> toJson() => _$NewMeetingToJson(this);

}