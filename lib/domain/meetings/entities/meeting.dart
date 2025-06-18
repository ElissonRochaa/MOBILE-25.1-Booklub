import 'package:booklub/utils/geo/types/latlng.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meeting.g.dart';

@JsonSerializable()
class Meeting {

  final String id;

  final String readingGoalId;

  final String clubId;

  final String address;

  final LatLng latlng;

  final DateTime date;

  final DateTime createdAt;

  Meeting({
    required this.id,
    required this.readingGoalId,
    required this.clubId,
    required this.address,
    required this.latlng,
    required this.date,
    required this.createdAt,
  });

  factory Meeting.fromJson(Map<String, dynamic> json) =>
      _$MeetingFromJson(json);

  Map<String, dynamic> toJson() => _$MeetingToJson(this);

}