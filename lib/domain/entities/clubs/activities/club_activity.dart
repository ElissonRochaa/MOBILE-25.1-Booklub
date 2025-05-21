import 'package:json_annotation/json_annotation.dart';

part 'club_activity.g.dart';

@JsonEnum(alwaysCreate: true)
enum ClubActivityCategory {
  @JsonValue('READINGS') readings,
  @JsonValue('MEETINGS') meetings;

  String? toJson() => _$ClubActivityCategoryEnumMap[this];

  static ClubActivityCategory? fromJson(String value) => _$ClubActivityCategoryEnumMap.map((key, value) => MapEntry(value, key))[value];

}

abstract class ClubActivity {

  final String clubId;

  final ClubActivityCategory category;

  const ClubActivity({
    required this.clubId,
    required this.category,
  });

}