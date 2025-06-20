// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthData _$AuthDataFromJson(Map<String, dynamic> json) => AuthData(
  user: User.fromJson(json['user'] as Map<String, dynamic>),
  token: AuthToken.fromJson(json['token'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AuthDataToJson(AuthData instance) => <String, dynamic>{
  'user': instance.user,
  'token': instance.token,
};
