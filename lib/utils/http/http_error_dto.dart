import 'package:json_annotation/json_annotation.dart';

part 'http_error_dto.g.dart';

@JsonSerializable()
class HttpErrorDTO {

  final int httpStatus;

  final String error;

  final String message;

  final DateTime timestamp;

  HttpErrorDTO({
    required this.httpStatus,
    required this.error,
    required this.message,
    required this.timestamp,
  });

  factory HttpErrorDTO.fromJson(Map<String, dynamic> json) => _$HttpErrorDTOFromJson(json);

  Map<String, dynamic> toJson() => _$HttpErrorDTOToJson(this);

}