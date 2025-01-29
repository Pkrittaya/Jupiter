import 'package:json_annotation/json_annotation.dart';
import 'package:jupiter_api/data/data_models/response/route_legs_item_model.dart';
import 'package:jupiter_api/data/data_models/response/route_legs_points_model.dart';
import 'package:jupiter_api/domain/entities/route_planning_entity.dart';

part 'route_planning_data_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class RoutePlanningDataModel extends RoutePlanningDataModelEntity {
  RoutePlanningDataModel({
    required this.legs,
    required this.polyline,
    required super.distanceMeters,
    required super.duration,
    required super.staticDuration,
  }) : super(legs: legs, polyline: polyline);

  @override
  @JsonKey(name: 'legs')
  final List<RoutesLegsItemModel> legs;

  @override
  @JsonKey(name: 'polyline')
  final RoutesLegsPointsModel polyline;

  factory RoutePlanningDataModel.fromJson(Map<String, dynamic> json) =>
      _$RoutePlanningDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$RoutePlanningDataModelToJson(this);
}
