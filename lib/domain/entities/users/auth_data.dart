import 'package:booklub/domain/entities/users/auth_token.dart';
import 'package:booklub/domain/entities/users/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_data.g.dart';

@JsonSerializable()
class AuthData {

  final User user;

  final AuthToken token;

  const AuthData({
    required this.user,
    required this.token,
  });

  factory AuthData.fromJson(Map<String, dynamic> json) => _$AuthDataFromJson(json);

  Map<String, dynamic> toJson() => _$AuthDataToJson(this);

}