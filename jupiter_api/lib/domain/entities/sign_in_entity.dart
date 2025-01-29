import 'package:json_annotation/json_annotation.dart';

import 'default_entity.dart';
import 'token_entity.dart';

class SignInEntity extends DefaultEntity {
  SignInEntity(
    this.token, {
    required super.message,
  });
  @JsonKey(name: 'token')
  final TokenEntity token;
}
