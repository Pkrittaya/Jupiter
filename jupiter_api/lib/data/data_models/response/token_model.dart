import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/token_entity.dart';

part 'token_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class TokenModel extends TokenEntity {
  TokenModel({required super.refreshToken, required super.accessToken});

  factory TokenModel.fromJson(Map<String, dynamic> json) =>
      _$TokenModelFromJson(json);
  Map<String, dynamic> toJson() => _$TokenModelToJson(this);
}
