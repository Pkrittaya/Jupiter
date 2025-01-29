import 'package:json_annotation/json_annotation.dart';
import 'package:jupiter_api/domain/entities/favorite_route_point_entity.dart';

part 'favorite_route_point_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class FavoriteRoutePointModel extends FavoriteRoutePointEntity {
  FavoriteRoutePointModel(
      {required super.name,
      required super.pointNo,
      required super.latitude,
      required super.longitude,
      required super.stationId,
      required super.stationName});

  factory FavoriteRoutePointModel.fromJson(Map<String, dynamic> json) =>
      _$FavoriteRoutePointModelFromJson(json);
  Map<String, dynamic> toJson() => _$FavoriteRoutePointModelToJson(this);
}
