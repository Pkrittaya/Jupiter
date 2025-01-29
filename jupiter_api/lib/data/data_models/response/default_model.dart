import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/default_entity.dart';

part 'default_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class DefaultModel extends DefaultEntity {
  DefaultModel({required super.message});

  factory DefaultModel.fromJson(Map<String, dynamic> json) =>
      _$DefaultModelFromJson(json);
  Map<String, dynamic> toJson() => _$DefaultModelToJson(this);
}
