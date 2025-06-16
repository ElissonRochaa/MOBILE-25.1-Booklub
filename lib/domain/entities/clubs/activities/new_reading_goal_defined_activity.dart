import 'package:booklub/domain/entities/clubs/activities/club_activity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'new_reading_goal_defined_activity.g.dart';

@JsonSerializable()
class NewReadingGoalDefinedActivity extends ClubActivity {

  final String bookId;

  final DateTime startDate;

  final DateTime endDate;

  const NewReadingGoalDefinedActivity({
    required super.clubId,
    required this.bookId,
    required this.startDate,
    required this.endDate,
  }): super(category: ClubActivityCategory.readings);

  factory NewReadingGoalDefinedActivity.fromJson(Map<String, dynamic> json) => _$NewReadingGoalDefinedActivityFromJson(json);

  Map<String, dynamic> toJson() => _$NewReadingGoalDefinedActivityToJson(this);

}