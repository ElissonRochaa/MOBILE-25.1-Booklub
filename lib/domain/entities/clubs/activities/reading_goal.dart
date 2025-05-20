import 'package:booklub/domain/entities/clubs/activities/club_activity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reading_goal.g.dart';

@JsonSerializable()
class ReadingGoal extends ClubActivity {

  final String bookId;

  final DateTime startDate;

  final DateTime finishDate;

  const ReadingGoal({
    required super.clubId,
    required this.bookId,
    required this.startDate,
    required this.finishDate,
  });

  factory ReadingGoal.fromJson(Map<String, dynamic> json) => _$ReadingGoalFromJson(json);

  Map<String, dynamic> toJson() => _$ReadingGoalToJson(this);

}