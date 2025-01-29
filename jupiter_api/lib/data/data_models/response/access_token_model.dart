import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/access_token_entity.dart';

part 'access_token_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class AccessTokenModel extends AccessTokenEntity {
  AccessTokenModel({required super.accessToken});

  factory AccessTokenModel.fromJson(Map<String, dynamic> json) =>
      _$AccessTokenModelFromJson(json);
  Map<String, dynamic> toJson() => _$AccessTokenModelToJson(this);
}
