import 'package:json_annotation/json_annotation.dart';

part 'reading_goal.g.dart';

@JsonSerializable()
class ReadingGoal {

  final String id;

  final String bookId;

  final String clubId;

  final DateTime startDate;

  final DateTime endDate;

  final DateTime createdAt;

  const ReadingGoal({
    required this.id,
    required this.bookId,
    required this.clubId,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
  });

  factory ReadingGoal.fromJson(Map<String, dynamic> json) => _$ReadingGoalFromJson(json);

  Map<String, dynamic> toJson() => _$ReadingGoalToJson(this);

}