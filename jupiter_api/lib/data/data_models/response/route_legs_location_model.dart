import 'package:json_annotation/json_annotation.dart';
import 'package:jupiter_api/domain/entities/route_planning_entity.dart';

part 'route_legs_location_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class RoutesLegsLocationModel extends RoutesLegsLocationEntity {
  RoutesLegsLocationModel({required super.lat, required super.lng});

  factory RoutesLegsLocationModel.fromJson(Map<String, dynamic> json) =>
      _$RoutesLegsLocationModelFromJson(json);
  Map<String, dynamic> toJson() => _$RoutesLegsLocationModelToJson(this);
}
