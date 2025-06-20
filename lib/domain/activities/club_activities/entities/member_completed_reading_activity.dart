import 'package:booklub/domain/activities/entities/activity.dart';
import 'package:json_annotation/json_annotation.dart';

import 'club_activity.dart';

part 'member_completed_reading_activity.g.dart';

@JsonSerializable()
class MemberCompletedReadingActivity extends ClubActivity {

  final String userId;

  final String bookId;

  MemberCompletedReadingActivity({
    required super.id,
    required super.createdAt,
    required super.type,
    required super.clubId,
    required this.userId,
    required this.bookId,
  });

  factory MemberCompletedReadingActivity.fromJson(Map<String, dynamic> json) =>
      _$MemberCompletedReadingActivityFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MemberCompletedReadingActivityToJson(this);
}