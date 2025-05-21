import 'package:json_annotation/json_annotation.dart';

part 'auth_token.g.dart';

@JsonSerializable()
class AuthToken {

  final String accessToken;

  final DateTime expiration;

  final String tokenType;

  const AuthToken({
    required this.accessToken,
    required this.expiration,
    required this.tokenType,
  });

  factory AuthToken.fromJson(Map<String, dynamic> json) => _$AuthTokenFromJson(json);

  Map<String, dynamic> toJson() => _$AuthTokenToJson(this);


}