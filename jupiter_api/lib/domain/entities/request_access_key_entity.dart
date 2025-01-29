import 'package:json_annotation/json_annotation.dart';

import 'access_token_entity.dart';
import 'default_entity.dart';

class RequestAccessKeyEntity extends DefaultEntity {
  RequestAccessKeyEntity(
    this.token, {
    required super.message,
  });
  @JsonKey(name: 'token')
  final AccessTokenEntity token;
}
