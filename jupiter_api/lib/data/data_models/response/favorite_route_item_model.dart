import 'package:json_annotation/json_annotation.dart';
import 'package:jupiter_api/data/data_models/response/favorite_route_point_model.dart';
import 'package:jupiter_api/domain/entities/favorite_route_item_entity.dart';

part 'favorite_route_item_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class FavoriteRouteItemModel extends FavoriteRouteItemEntity {
  FavoriteRouteItemModel({
    required super.routeName,
    required super.routeDistance,
    required super.routeDuration,
    required this.routePoint,
  }) : super(routePoint: routePoint);

  @override
  @JsonKey(name: 'route_point')
  final List<FavoriteRoutePointModel> routePoint;

  factory FavoriteRouteItemModel.fromJson(Map<String, dynamic> json) =>
      _$FavoriteRouteItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$FavoriteRouteItemModelToJson(this);
}
