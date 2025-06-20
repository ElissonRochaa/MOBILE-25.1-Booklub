import 'package:json_annotation/json_annotation.dart';
part 'reading_goal_creation_dto.g.dart';

@JsonSerializable()
class CreateReadingGoalDto {
  final String bookId;
  final String startDate;
  final String endDate;

  CreateReadingGoalDto({
    required this.bookId,
    required this.startDate,
    required this.endDate,
  });

  factory CreateReadingGoalDto.fromJson(Map<String, dynamic> json) => _$CreateReadingGoalDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreateReadingGoalDtoToJson(this);
}