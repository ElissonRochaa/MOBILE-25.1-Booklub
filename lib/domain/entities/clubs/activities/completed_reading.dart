import 'package:booklub/domain/entities/clubs/activities/club_activity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'completed_reading.g.dart';

@JsonSerializable()
class CompletedReading extends ClubActivity {

  final String bookId;

  final String userId;

  final DateTime startDate;

  final DateTime finishDate;

  CompletedReading({
    required super.clubId,
    required this.bookId,
    required this.userId,
    required this.startDate,
    required this.finishDate,
  }): super(
    category: ClubActivityCategory.readings
  );

  factory CompletedReading.fromJson(Map<String, dynamic> json) =>
      _$CompletedReadingFromJson(json);

  Map<String, dynamic> toJson() => _$CompletedReadingToJson(this);

}