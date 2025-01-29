import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/duration_entity.dart';

part 'duration_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class DurationModel extends DurationEntity {
  DurationModel(
      {required super.index,
      required super.day,
      required super.status,
      required super.start,
      required super.end,
      required super.duration});

  factory DurationModel.fromJson(Map<String, dynamic> json) =>
      _$DurationModelFromJson(json);
  Map<String, dynamic> toJson() => _$DurationModelToJson(this);
}
