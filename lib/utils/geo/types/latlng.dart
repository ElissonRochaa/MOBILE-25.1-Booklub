import 'package:json_annotation/json_annotation.dart';

part 'latlng.g.dart';

@JsonSerializable()
class LatLng {

  final double latitude;

  final double longitude;

  LatLng({
    required this.latitude,
    required this.longitude,
  });

  factory LatLng.fromJson(Map<String, dynamic> json) =>
      _$LatLngFromJson(json);

  Map<String, dynamic> toJson() => _$LatLngToJson(this);

}