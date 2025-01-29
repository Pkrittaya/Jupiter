import 'package:json_annotation/json_annotation.dart';
import 'package:jupiter_api/data/data_models/response/route_legs_latlng_model.dart';
import 'package:jupiter_api/data/data_models/response/route_legs_points_model.dart';
import 'package:jupiter_api/domain/entities/route_planning_entity.dart';

part 'route_legs_item_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class RoutesLegsItemModel extends RoutesLegsItemEntity {
  RoutesLegsItemModel(
      {required super.distanceMeters,
      required super.duration,
      required super.staticDuration,
      required this.polyline,
      required this.startLocation,
      required this.endLocation})
      : super(
            polyline: polyline,
            startLocation: startLocation,
            endLocation: endLocation);

  @override
  @JsonKey(name: 'polyline')
  final RoutesLegsPointsModel polyline;
  @override
  @JsonKey(name: 'startLocation')
  final RoutesLegsLatLngModel startLocation;
  @override
  @JsonKey(name: 'endLocation')
  final RoutesLegsLatLngModel endLocation;

  factory RoutesLegsItemModel.fromJson(Map<String, dynamic> json) =>
      _$RoutesLegsItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$RoutesLegsItemModelToJson(this);
}
