import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/facility_entity.dart';

part 'facility_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class FacilityModel extends FacilityEntity {
  FacilityModel({
    required super.facilityName,
    required super.image,
  });
  factory FacilityModel.fromJson(Map<String, dynamic> json) =>
      _$FacilityModelFromJson(json);
  Map<String, dynamic> toJson() => _$FacilityModelToJson(this);
}
