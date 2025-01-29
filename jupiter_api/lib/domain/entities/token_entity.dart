import 'package:json_annotation/json_annotation.dart';

class TokenEntity {
  TokenEntity({
    required this.refreshToken,
    required this.accessToken,
  });
  @JsonKey(name: 'refresh_token')
  final String refreshToken;
  @JsonKey(name: 'access_token')
  final String accessToken;
}
