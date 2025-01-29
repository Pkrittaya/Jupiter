import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/request_access_key_entity.dart';
import 'access_token_model.dart';

part 'request_access_key_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class RequestAccessKeyModel extends RequestAccessKeyEntity {
  RequestAccessKeyModel(this.token, {required String message})
      : super(token, message: message);
  @override
  @JsonKey(name: 'token')
  final AccessTokenModel token;

  factory RequestAccessKeyModel.fromJson(Map<String, dynamic> json) =>
      _$RequestAccessKeyModelFromJson(json);
  Map<String, dynamic> toJson() => _$RequestAccessKeyModelToJson(this);
}
