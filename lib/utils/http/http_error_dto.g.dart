// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'http_error_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HttpErrorDTO _$HttpErrorDTOFromJson(Map<String, dynamic> json) => HttpErrorDTO(
  httpStatus: (json['httpStatus'] as num).toInt(),
  error: json['error'] as String,
  message: json['message'] as String,
  timestamp: DateTime.parse(json['timestamp'] as String),
);

Map<String, dynamic> _$HttpErrorDTOToJson(HttpErrorDTO instance) =>
    <String, dynamic>{
      'httpStatus': instance.httpStatus,
      'error': instance.error,
      'message': instance.message,
      'timestamp': instance.timestamp.toIso8601String(),
    };
