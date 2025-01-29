import 'package:json_annotation/json_annotation.dart';

import 'default_entity.dart';

class VerifyCardEntity extends DefaultEntity {
  VerifyCardEntity({required super.message, required this.url});
  @JsonKey(name: 'url')
  final String url;
}
