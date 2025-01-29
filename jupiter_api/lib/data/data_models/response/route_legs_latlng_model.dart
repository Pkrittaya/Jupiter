import 'package:json_annotation/json_annotation.dart';
import 'package:jupiter_api/data/data_models/response/route_legs_location_model.dart';
import 'package:jupiter_api/domain/entities/route_planning_entity.dart';

part 'route_legs_latlng_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class RoutesLegsLatLngModel extends RoutesLegsLatLngEntity {
  RoutesLegsLatLngModel({
    required this.latLng,
  }) : super(
          latLng: latLng,
        );

  @override
  @JsonKey(name: 'latLng')
  final RoutesLegsLocationModel latLng;

  factory RoutesLegsLatLngModel.fromJson(Map<String, dynamic> json) =>
      _$RoutesLegsLatLngModelFromJson(json);
  Map<String, dynamic> toJson() => _$RoutesLegsLatLngModelToJson(this);
}
