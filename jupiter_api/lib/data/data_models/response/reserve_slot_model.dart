import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/reserve_slot_entity.dart';

part 'reserve_slot_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class ReserveSlotModel extends ReserveSlotEntity {
  ReserveSlotModel({
    required super.index,
    required super.day,
    required super.start,
    required super.end,
    required super.duration,
    required super.status,
  });

  factory ReserveSlotModel.fromJson(Map<String, dynamic> json) =>
      _$ReserveSlotModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReserveSlotModelToJson(this);
}
