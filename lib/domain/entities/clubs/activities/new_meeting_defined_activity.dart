import 'package:booklub/domain/entities/clubs/activities/club_activity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'new_meeting_defined_activity.g.dart';

@JsonSerializable()
class NewMeetingDefinedActivity extends ClubActivity {

  final String bookId;

  final String location;

  final List<String> participantsIds;

  final DateTime date;

  const NewMeetingDefinedActivity({
    required super.clubId,
    required this.bookId,
    required this.location,
    required this.participantsIds,
    required this.date,
  }): super(
    category: ClubActivityCategory.meetings
  );

  factory NewMeetingDefinedActivity.fromJson(Map<String, dynamic> json) => _$NewMeetingDefinedActivityFromJson(json);

  Map<String, dynamic> toJson() => _$NewMeetingDefinedActivityToJson(this);

}