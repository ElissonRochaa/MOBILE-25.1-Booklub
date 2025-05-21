import 'package:json_annotation/json_annotation.dart';

part 'club_activity.g.dart';

@JsonEnum(alwaysCreate: true)
enum ClubActivityCategory {
  @JsonValue('READINGS') readings,
  @JsonValue('MEETINGS') meetings,
}

abstract class ClubActivity {

  final String clubId;

  final ClubActivityCategory category;

  const ClubActivity({
    required this.clubId,
    required this.category,
  });

}