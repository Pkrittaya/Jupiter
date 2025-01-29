import 'package:json_annotation/json_annotation.dart';
import 'package:jupiter_api/domain/entities/route_planning_entity.dart';

part 'route_legs_points_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class RoutesLegsPointsModel extends RoutesLegsPointsEntity {
  RoutesLegsPointsModel({
    required super.encodedPolyline,
  });

  factory RoutesLegsPointsModel.fromJson(Map<String, dynamic> json) =>
      _$RoutesLegsPointsModelFromJson(json);
  Map<String, dynamic> toJson() => _$RoutesLegsPointsModelToJson(this);
}
