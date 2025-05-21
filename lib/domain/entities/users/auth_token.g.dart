// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthToken _$AuthTokenFromJson(Map<String, dynamic> json) => AuthToken(
  accessToken: json['accessToken'] as String,
  expiration: DateTime.parse(json['expiration'] as String),
  tokenType: json['tokenType'] as String,
);

Map<String, dynamic> _$AuthTokenToJson(AuthToken instance) => <String, dynamic>{
  'accessToken': instance.accessToken,
  'expiration': instance.expiration.toIso8601String(),
  'tokenType': instance.tokenType,
};
