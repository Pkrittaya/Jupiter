import 'package:json_annotation/json_annotation.dart';

class AccessTokenEntity {
  AccessTokenEntity({
    required this.accessToken,
  });
  @JsonKey(name: 'access_token')
  final String accessToken;
}
