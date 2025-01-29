import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/optional_detail_entity.dart';

part 'optional_detail_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class OptionalDetailModel extends OptionalDetailEntity {
  OptionalDetailModel({
    required super.optionalType,
    required super.optionalValue,
    required super.optionalUnit,
  });
  factory OptionalDetailModel.fromJson(Map<String, dynamic> json) =>
      _$OptionalDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$OptionalDetailModelToJson(this);
}
