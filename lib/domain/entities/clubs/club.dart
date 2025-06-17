import 'package:json_annotation/json_annotation.dart';

part 'club.g.dart';

@JsonSerializable()
class Club {

  final String id;

  final String name;

  final DateTime creationDate;

  final String? imageUrl;

  final bool isPrivate;

  final String ownerId;

  final int totalMembers;


  const Club({
    required this.id,
    required this.name,
    required this.creationDate,
    required this.imageUrl,
    required this.isPrivate,
    required this.ownerId,
    required this.totalMembers
  });

  factory Club.fromJson(Map<String, dynamic> json) => _$ClubFromJson(json);

  Map<String, dynamic> toJson() => _$ClubToJson(this);

}