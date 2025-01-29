import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/verify_card_entity.dart';

part 'verify_card_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class VerifyCardModel extends VerifyCardEntity {
  VerifyCardModel({required super.message, required super.url});

  factory VerifyCardModel.fromJson(Map<String, dynamic> json) =>
      _$VerifyCardModelFromJson(json);
  Map<String, dynamic> toJson() => _$VerifyCardModelToJson(this);
}
